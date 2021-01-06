class HomesController < ApplicationController
  def top
    @user = current_user
    @murmur = Murmur.new
  end

  def about
  end
end
