class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment_params = params.require(:comment).permit(:message)
    comment_params[:user] = current_user
    comment = post.comments.build(comment_params)
    if comment.save
      redirect_to post, notice: t(".success")
    else
      redirect_to post, alert: t(".error")
    end
  end
end
