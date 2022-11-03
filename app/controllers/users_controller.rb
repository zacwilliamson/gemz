class UsersController < ApplicationController
  before_action :set_user, only: %i[show friends notifications]
  before_action :log_in_user

  def index
    @users = if params[:username].nil?
               set_users
             else
               User.find_friends(params[:username])
                   .order('username DESC')
                   .page(params[:page])
             end
  end

  def show
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
    User.where(['id not in (?)', friend_ids])
        .order('username DESC')
        .page(params[:page])
  end

  def set_posts
    Post.where(['user_id = ?', @user.id])
        .order('created_at DESC')
        .page(params[:page])
  end

  def friend_ids
    current_user.friends.map(&:id) << current_user.id
  end
end
