class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = post.comments.build(params.require(:comment).permit(:message))
    if comment.save
      redirect_to post, notice: t(".success")
    else
      redirect_to post, alert: t(".error")
    end
  end
end
