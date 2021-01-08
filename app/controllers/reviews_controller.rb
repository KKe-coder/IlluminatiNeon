class ReviewsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    review = current_user.reviews.new(review_params)
    review.post_id = post.id
    review.save
    redirect_to post_path(post)
  end

  def destroy
    Review.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rate)
  end

end
