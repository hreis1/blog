class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :authorize_user!, except: [ :index, :show, :create, :new ]
  before_action :set_post, except: [ :index, :create, :new ]

  def index
    @posts = Post.active.order(created_at: :desc).page(params[:page]).per(3)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: t(".success")
    else
      flash.now[:alert] = t(".error")
      render "new", status: :unprocessable_entity
    end
  end

  def new
    @post = Post.new
  end

  def edit; end

  def show
    @comment = Comment.new
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t(".success")
    else
      flash.now[:notice] = t(".error")
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @post.deleted!

    redirect_to posts_path, notice: t(".success")
  end


  private


  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    return if current_user == Post.find(params[:id]).user

    redirect_to root_path, alert: t("unauthorized")
  end
end
