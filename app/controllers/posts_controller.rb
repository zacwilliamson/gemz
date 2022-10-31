class PostsController < ApplicationController
  before_action :set_post, only: %i[destroy edit update show correct_user]
  before_action :correct_user, only: %i[destroy edit update]
  before_action :log_in_user

  def index
    return unless user_signed_in?

    @post = current_user.posts.build
    @feed = set_feed
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = 'Your post is live'
      redirect_to root_url
    else
      redirect_to root_url, status: :unprocessable_entity
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

  def show
    @comments = @post.comments
  end

  def edit; end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_feed
    Post.where(['user_id = ? or user_id in (?)', current_user.id, active_friend_ids])
        .order('created_at DESC')
        .page(params[:page])
  end

  def correct_user
    redirect_to root_url, status: :see_other unless @post.user == current_user
  end

  def active_friend_ids
    current_user.active_friends.map(&:id)
  end
end
