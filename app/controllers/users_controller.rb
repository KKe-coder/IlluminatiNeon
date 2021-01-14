class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @murmurs = (Murmur.where(user_id: @user.id)).reverse
    @posts = (Post.where(user_id: @user.id)).reverse
    if user_signed_in? && @user == current_user
      @murmurs = (Murmur.where(user_id: @user.followings.ids) + Murmur.where(user_id: @user.id)).sort.reverse
      @posts = (Post.where(user_id: @user.followings.ids) + Post.where(user_id: @user.id)).sort.reverse
      case params[:showing]
      when "current_user_posts"
        @murmurs = (Murmur.where(user_id: @user.id)).reverse
        @posts = (Post.where(user_id: @user.id)).reverse
      end
    end
  end

  def unsubscribe
    if current_user.email == 'guest@example.com'
      redirect_to user_path(current_user.id), alert: 'ゲストユーザーの変更・削除はできません。'
    end
  end

  def withdraw
    @user = current_user
    if @user.email == 'guest@example.com'
      redirect_to user_path(@user.id), alert: 'ゲストユーザーの変更・削除はできません。'
    else
      @user.is_deleted = true
      @user.update(user_is_deleted)
      UnsubscribeMailer.unsubscribe_mail(@user).deliver_now
      reset_session
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :residence)
  end

  def user_is_deleted
    params.permit(:is_deleted)
  end

end
