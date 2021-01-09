class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :murmur_post

  def murmur_post
    @header_user = current_user
    @header_murmur = Murmur.new
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :residence, :profile_image])
  end
end
