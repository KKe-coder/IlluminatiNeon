module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    html = ""
    messages = resource.errors.full_messages.each do |errmsg|
      html += <<-EOF
      <p class="alert-info">
        <i class="fas fa-exclamation-triangle"></i>#{errmsg}
      </p>
      EOF
    end
    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

end