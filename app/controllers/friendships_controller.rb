class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:friend_id])
    current_user.add_friend(user)
    redirect_to user
  end

  def destroy
    friendship = Friendship.find(params[:id])
    friend = friendship.friend
    current_user.unfriend(friend)
    redirect_to friend, status: :see_other
  end
end
