class MurmursController < ApplicationController

  def create
    user = current_user
    murmur = Murmur.new(murmur_params)
    murmur.user_id = user.id
    murmur.save
    redirect_to request.referer
  end

  def destroy
    Murmur.find_by(user_id: params[:user_id], id: params[:id]).destroy
    redirect_to request.referer
  end

  private

  def murmur_params
    params.require(:murmur).permit(:body)
  end

end
