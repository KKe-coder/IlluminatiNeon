class PostsController < ApplicationController

  def index
    case params[:posts_category]
    when "Illumination"
      @posts = Post.where(category: "Illumination")
    when "Neon"
      @posts = Post.where(category: "Neon")
    else
      @posts = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
    @review = Review.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.avgrate = @post.rate
    @post.save
    redirect_to post_path(@post.id)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.avgrate = (@post.reviews.sum(:rate) + @post.rate / @post.reviews.count + 1)
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :category, :color, :place, :rate, :impression, :avgrate)
  end

end
