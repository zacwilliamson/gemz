class PostsController < ApplicationController
  before_action :set_post, only: %i[destroy edit update show correct_user]
  before_action :correct_user, only: %i[destroy edit update]
  before_action :log_in_user

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = 'Your post is live'
      redirect_to root_url
    else
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = 'Your post was deleted'
    redirect_to root_url, status: :see_other
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Your post was updated'
      redirect_to post_url(@post)
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  def edit; end

  def show; end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    redirect_to root_url, status: :see_other unless @post.user == current_user
  end
end
