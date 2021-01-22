class ReviewsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    review = current_user.reviews.new(review_params)
    review.post_id = @post.id
    if review.save
      @post.avgrate = ((@post.reviews.sum(:rate) + @post.rate) / (@post.reviews.count + 1))
      @post.update(post_params)
    else
      if review.errors.full_messages.any? { |t| "Commentを入力してください".include?(t) }
        render 'error4commentblank'
      elsif review.errors.full_messages.any? { |t| "Commentは20文字以内で入力してください".include?(t) }
        render 'error4commentlong'
      else
        render 'error4raty'
      end
    end
  end

  def destroy
    Review.find_by(id: params[:id], post_id: params[:post_id]).destroy
    @post = Post.find(params[:post_id])
    @post.avgrate = ((@post.reviews.sum(:rate) + @post.rate) / (@post.reviews.count + 1))
    @post.update(post_params)
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rate)
  end

  def post_params
    params.permit(:avgrate)
  end

end
