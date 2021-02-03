require 'base64'
require 'json'
require 'net/https'

module Vision
  class << self
    def get_image_data(image_file)
      # APIのURL作成
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_API_KEY']}"

      # 画像をbase64にエンコード※本番環境と開発環境での条件分岐を行う。
      if Rails.env.production?
        require 'aws-sdk'
        client = Aws::S3::Client.new(
                                      :region => 'ap-northeast-1',
                                      :access_key_id => ENV['S3_PRODUCTION_COLOR_KEY'],
                                      :secret_access_key => ENV['S3_PRODUCTION_SECRET_KEY'],
                                    )
        image_object = client.get_object(:bucket => 'illuminatineon', :key => '#{image_file.id}').body.read
        base64_image = Base64.encode64(image_object)
      else
        base64_image = Base64.encode64(open("#{Rails.root}/public/uploads/#{image_file.id}").read)
      end
      # APIリクエスト用のJSONパラメータ
      params = {
        requests: [{
          image: {
            content: base64_image
          },
          features: [
            {
              type: 'IMAGE_PROPERTIES'
            }
          ]
        }]
      }.to_json

      # Google Cloud Vision APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      response_body = JSON.parse(response.body)
      # APIレスポンス出力
      if (error = response_body['responses'][0]['error']).present?
        raise error['message']
      else
        JSON.parse(response.body)['responses'][0]['imagePropertiesAnnotation']['dominantColors']['colors'].pluck('color')[2]
      end
    end
  end
end