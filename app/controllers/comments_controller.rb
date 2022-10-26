class CommentsController < ApplicationController
  before_action :log_in_user

  def create
    post = Post.find(params[:post_id])
    @comment = current_user.comments.create(post: post, content: params[:comment][:content])
    redirect_to request.referrer
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy
    redirect_to request.referrer, status: :see_other
  end
end
