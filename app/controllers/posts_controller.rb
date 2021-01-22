class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:posts_place]
      @posts = Post.where(place: params[:posts_place]).reverse
      @condition = "場所が" + params[:posts_place] + "の投稿"
    elsif params[:category]
      @posts = Post.where(category: params[:category]).reverse
      @condition = "カテゴリーが" + params[:category] + "の投稿"
    elsif params[:color]
      @posts = Post.where(color: params[:color]).reverse
      @condition = "カラーが" + params[:color] + "の投稿"
    elsif params[:favorited]
      @posts = Post.where(id: Favorite.where(user_id: params[:favorited]).pluck(:post_id)).reverse
      # お気に入りの中から、パラメータのuser_idを持つfavoriteを探し出し、そのpost_idカラムをpluckメソッドで配列化し、基づくPostを逆順にして返す
      @condition = User.find(params[:favorited]).name + "さんがいいねした投稿"
    elsif params[:rated]
      if params[:rated] == "up"
        @posts = Post.order(avgrate: :DESC)
        @condition = "評価が高い順"
      else
        @posts = Post.order(:avgrate)
        @condition = "評価が低い順"
      end
    elsif params[:favoritecount]
      if params[:favoritecount] == "up"
        @posts = Post.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
        @condition = "いいね数が多い順"
      else
        @posts = Post.includes(:favorited_users).sort.reverse {|a,b| b.favorited_users.size <=> a.favorited_users.size}
        @condition = "いいね数が少ない順"
      end
    elsif params[:reviewcount]
      if params[:reviewcount] == "up"
        @posts = Post.includes(:reviewed_users).sort {|a,b| b.reviewed_users.size <=> a.reviewed_users.size}
        @condition = "レビュー数が多い順"
      else
        @posts = Post.includes(:reviewed_users).sort.reverse {|a,b| b.reviewed_users.size <=> a.reviewed_users.size}
        @condition = "レビュー数が少ない順"
      end
    else
      @posts = Post.all.reverse
      @condition = "なし"
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
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to post_path(@post.id)
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.avgrate = ((@post.reviews.sum(:rate) + @post.rate) / (@post.reviews.count + 1))
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
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
