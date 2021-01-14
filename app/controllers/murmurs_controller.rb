class MurmursController < ApplicationController

  def create
    user = current_user
    murmur = Murmur.new(murmur_params)
    murmur.user_id = user.id
    murmur.save
    @user = User.find(params[:user_id])
    if params[:murmur][:id]
      @user = User.find(params[:murmur][:id])
    end
    @murmurs = (Murmur.where(user_id: @user.id)).reverse
      if user_signed_in? && @user == current_user
        @murmurs = (Murmur.where(user_id: @user.followings.ids) + Murmur.where(user_id: @user.id)).sort.reverse
        case params[:murmur][:showing]
        when "current_user_posts"
        @murmurs = (Murmur.where(user_id: @user.id)).reverse
        end
      end
  end

  def destroy
    Murmur.find_by(user_id: params[:user_id], id: params[:id]).destroy
    @user = User.find(params[:user_id])
    @murmurs = (Murmur.where(user_id: @user.followings.ids) + Murmur.where(user_id: @user.id)).sort.reverse # ログイン中Userのフォロワータイムライン
    case params[:mypageview]
    when "on"
      @murmurs = (Murmur.where(user_id: @user.id)).reverse
    end
  end

  private

  def murmur_params
    params.require(:murmur).permit(:body)
  end

end
