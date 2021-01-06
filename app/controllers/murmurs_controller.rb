class MurmursController < ApplicationController

  def create
    user = current_user
    murmur = Murmur.new(murmur_params)
    murmur.user_id = user.id
    murmur.save
    redirect_to request.referer
  end

  def destroy
  end

  private

  def murmur_params
    params.require(:murmur).permit(:body)
  end

end
