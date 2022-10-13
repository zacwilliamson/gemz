class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:friend_id])
    current_user.add_friend(user)
    request = user.recived_friendships.find_by(user: current_user)
    notify(user, request)
    redirect_to user
  end

  def destroy
    friendship = Friendship.find(params[:id])
    friend = select_friend(friendship)
    current_user.unfriend(friend)
    redirect_to friend, status: :see_other
  end

  private

  def select_friend(friendship)
    if friendship.friend == current_user
      friendship.user
    else
      friendship.friend
    end
  end

  def notify(user, request)
    user.notifications.create(notifiable: request)
  end
end
