class CommentsController < ApplicationController
  before_action :log_in_user
  before_action :set_post, only: %i[create destroy]

  def create
    @comment = @post.comments.create(comment_params)
    notify(@post.user, @comment)
    redirect_to post_path(@post)
  end

  def destroy
    comment = @post.comments.find(params[:id])
    comment.destroy
    redirect_to post_path(@post), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :parent_id)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def notify(user, comment)
    return if current_user == user

    user.notifications.create(notifiable: comment)
  end
end
