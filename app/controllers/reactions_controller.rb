class ReactionsController < ApplicationController
  before_action :log_in_user

  def create
    reactable = Post.find(params[:reactable_id])
    Reaction.create(user: current_user, reactable: reactable)
    reaction = current_user.reactions.find_by(reactable: reactable)
    notify(reactable.user, reaction) unless reactable.user == current_user
    redirect_to request.referrer
  end

  def destroy
    reaction = current_user.reactions.find(params[:id])
    reaction.destroy
    redirect_to request.referrer, status: :see_other
  end

  private

  def notify(user, reaction)
    user.notifications.create(notifiable: reaction)
  end
end
