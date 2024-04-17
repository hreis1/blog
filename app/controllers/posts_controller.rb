class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update ]
  before_action :authorize_user!, only: [ :edit, :update ]

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
      render "new", status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    post_params = params.require(:post).permit(:title, :content)
    if @post.update(post_params)
      redirect_to @post, notice: t(".success")
    else
      flash.now[:notice] = t(".error")
      render "edit", status: :unprocessable_entity
    end
  end

  private


  def authorize_user!
    return if current_user == Post.find(params[:id]).user

    redirect_to root_path, alert: t("unauthorized")
  end
end
