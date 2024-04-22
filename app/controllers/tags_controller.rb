class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.active.order(created_at: :desc).page(params[:page]).per(3)
  end

  def search
    return redirect_to request.referrer, alert: t(".empty_search") if params[:tag].blank?

    @tag = Tag.find_by(name: params[:tag])
    if @tag
      @posts = @tag.posts.active.order(created_at: :desc).page(params[:page]).per(3)
      render :show
    else
      redirect_to root_path, alert: t(".not_found", tag: params[:tag])
    end
  end
end
