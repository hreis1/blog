class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.active.order(created_at: :desc).page(params[:page]).per(3)
  end

  def search
    @query = params[:query]
    return redirect_to request.referrer, alert: t(".empty_search") if @query.blank?

    @tag = Tag.find_by(name: @query)
    if @tag
      @posts = @tag.posts.active.order(created_at: :desc).page(params[:page]).per(3)
      render :show
    else
      redirect_to root_path, alert: t(".not_found", tag: @query)
    end
  end
end
