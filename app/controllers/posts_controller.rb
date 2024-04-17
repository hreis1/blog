class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    post_params = params.require(:post).permit(:title, :content)
    post_params[:user] = current_user
    @post = Post.build(post_params)
    if @post.save
      redirect_to @post, notice: t(".success")
    else
      flash.now[:alert] = t(".error")
      render 'new', status: :unprocessable_entity
    end
  end
end
