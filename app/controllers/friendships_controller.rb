class FriendshipsController < ApplicationController
  before_action :log_in_user

  # Clean these up!

  def create
    user = User.find(params[:friend_id])
    current_user.add_friend(user)
    friendship = user.recived_friendships.find_by(user: current_user)
    notify(user, friendship)
    respond_to do |format|
      format.html { redirect_to request.referrer }
      # format.turbo_stream
    end
  end

  def destroy
    friendship = Friendship.find(params[:id])
    friend = select_friend(friendship)
    current_user.unfriend(friend)
    respond_to do |format|
      format.html { redirect_to request.referrer, status: :see_other }
      # format.turbo_stream
    end
  end

  private

  def select_friend(friendship)
    if friendship.friend == current_user
      friendship.user
    else
      friendship.friend
    end
  end

  def notify(user, friendship)
    user.notifications.create(notifiable: friendship)
  end
end

# Turbo works via so-called Turbo streams to send small snippets of HTML directly to the page using WebSockets, which is a technology that allows for a persistent connection between the client (e.g., a web browser) and the web server.
