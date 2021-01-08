class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def unsubscribe
  end

  def withdraw
    @user = current_user
    @user.is_deleted = true
    @user.update(user_is_deleted)
    UnsubscribeMailer.unsubscribe_mail(@user).deliver_now
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :residence)
  end

  def user_is_deleted
    params.permit(:is_deleted)
  end

end
