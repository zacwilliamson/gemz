class PostsController < ApplicationController
  before_action :set_post, only: %i[destroy edit update show]

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Your post is live'
      redirect_to root_url
    else
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Micropost deleted'
    redirect_to root_url, status: :see_other
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  def show; end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
