class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:posts_place]
      @posts = Post.where(place: params[:posts_place]).reverse
      @condition = "場所が" + params[:posts_place] + "の投稿"
    elsif params[:category]
      @posts = Post.where(category: params[:category]).reverse
      @condition = "カテゴリーが" + params[:category] + "の投稿"
    elsif params[:color]
      @posts = Post.where(color: params[:color]).reverse
      @condition = "カラーが" + params[:color] + "の投稿"
    elsif params[:favorited]
      @posts = Post.where(id: Favorite.where(user_id: params[:favorited]).pluck(:post_id)).reverse
      # お気に入りの中から、パラメータのuser_idを持つfavoriteを探し出し、そのpost_idカラムをpluckメソッドで配列化し、基づくPostを逆順にして返す
      @condition = User.find(params[:favorited]).name + "さんがいいねした投稿"
    elsif params[:rated]
      if params[:rated] == "up"
        @posts = Post.order(avgrate: :DESC)
        @condition = "評価が高い順"
      else
        @posts = Post.order(:avgrate)
        @condition = "評価が低い順"
      end
    elsif params[:favoritecount]
      if params[:favoritecount] == "up"
        @posts = Post.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
        @condition = "いいね数が多い順"
      else
        @posts = Post.includes(:favorited_users).sort.reverse {|a,b| b.favorited_users.size <=> a.favorited_users.size}
        @condition = "いいね数が少ない順"
      end
    elsif params[:reviewcount]
      if params[:reviewcount] == "up"
        @posts = Post.includes(:reviewed_users).sort {|a,b| b.reviewed_users.size <=> a.reviewed_users.size}
        @condition = "レビュー数が多い順"
      else
        @posts = Post.includes(:reviewed_users).sort.reverse {|a,b| b.reviewed_users.size <=> a.reviewed_users.size}
        @condition = "レビュー数が少ない順"
      end
    else
      @posts = Post.all.reverse
      @condition = "なし"
    end
  end

  def show
    @post = Post.find(params[:id])
    @review = Review.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.avgrate = @post.rate
    if @post.save
      $visionmode = "safesearch"
      safesearch = Vision.get_image_data(@post.image)
      unless safesearch.value?("LIKELY") || safesearch.value?("VERY_LIKELY") || safesearch.value?("POSSIBLE")
        $visionmode = "color"
        dominant_color = Vision.get_image_data(@post.image).values
        colors = { "Red" => [220, 53, 69], "Orange" => [255, 153, 51], "Yellow" => [255, 193, 7], "Green" => [40, 167, 69], "Blue" => [0, 123, 255], "Indigo" => [51, 51, 204], "Purple" => [153, 51, 255]}
        distance = {}
        colors.each{|key, value|
          r = "#{(value[0] - dominant_color[0])**2}"
          g = "#{(value[1] - dominant_color[1])**2}"
          b = "#{(value[2] - dominant_color[2])**2}"
          distance[key] = "#{((r + g + b).to_i**(1 / 2.0)).round}"
          #ここまででColor differenceのHashを作成
        }
        sorted_dis = distance.sort {|(k1, v1), (k2, v2)| v1.to_i <=> v2.to_i }.to_h
        @post.update(color: sorted_dis.first.first)
        redirect_to post_path(@post.id)
      else
        @post.destroy
        @post.errors.messages[:image] = ["が不適切な可能性があります"]
        render :new
      end
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to post_path(@post.id)
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.avgrate = ((@post.reviews.sum(:rate) + @post.rate) / (@post.reviews.count + 1))
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :category, :color, :place, :rate, :impression, :avgrate)
  end

end
