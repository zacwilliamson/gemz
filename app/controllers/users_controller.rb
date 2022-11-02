class UsersController < ApplicationController
  before_action :set_user, only: %i[show friends notifications]
  before_action :log_in_user

  def index
    @users = set_users
  end

  def show
    @add_friend = add_friend_btn
    @unfriend = unfriend_btn
    @posts = set_posts
  end

  def friends
    @friends = @user.active_friends
  end

  def notifications
    if current_user == @user
      @new = @user.new_notifications
      @old = @user.old_notifications
      @new.each(&:read)
    else
      redirect_to notifications_user_path(current_user)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_users
    User.where(['id not in (?) and id !=(?)', friend_ids, current_user.id])
        .order('username DESC')
        .page(params[:page])
  end

  def set_posts
    Post.where(['user_id = ?', @user.id])
        .order('created_at DESC')
        .page(params[:page])
  end

  def friend_ids
    current_user.friends.map(&:id)
  end

  def add_friend_btn
    if current_user.recived_request?(@user)
      'Accept'
    else
      'Add friend'
    end
  end

  def unfriend_btn
    if current_user.recived_request?(@user)
      'Decline'
    elsif current_user.pending_friends.include?(@user)
      'Request sent'
    else
      'Unfriend'
    end
  end
end
