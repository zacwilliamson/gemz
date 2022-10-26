class CommentsController < ApplicationController
  before_action :log_in_user

  def create
    post = Post.find(params[:post_id])
    @comment = current_user.comments.create(post: post, content: params[:comment][:content])
    redirect_to request.referrer
  end

  def edit; end

  def destroy; end
end
