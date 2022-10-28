class CommentsController < ApplicationController
  before_action :log_in_user

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.create(comment_params)
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])
    comment.destroy
    redirect_to post_path(post), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end
