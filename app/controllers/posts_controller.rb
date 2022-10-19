class PostsController < ApplicationController
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
    post = Post.find(params[:id])
    post.delete
    flash[:success] = 'Micropost deleted'
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  def show; end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
