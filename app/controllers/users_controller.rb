class UsersController < ApplicationController
  before_action :set_user, only: %i[show friends notifications]
  before_action :log_in_user

  def show
    @add_friend = add_friend_btn
    @unfriend = unfriend_btn
  end

  def friends
    @friends = @user.active_friends
  end

  def notifications
    if current_user == @user
      @new = @user.new_notifications.reverse
      @old = @user.old_notifications.reverse
      @new.each do |n|
        n.was_read = true
        n.save
      end
    else
      redirect_to notifications_user_path(current_user)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
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
