class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.active.order(created_at: :desc).page(params[:page]).per(3)
  end
end
