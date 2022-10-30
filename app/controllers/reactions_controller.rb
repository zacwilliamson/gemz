class ReactionsController < ApplicationController
  before_action :log_in_user

  def create
    reactable = Post.find(params[:reactable_id]) # instead of Post.find, needs to be Reactable.find
    reaction = current_user.reactions.create(reactable: reactable)
    notify(reactable.user, reaction)
    redirect_to request.referrer
  end

  def destroy
    reaction = current_user.reactions.find(params[:id])
    reaction.destroy
    redirect_to request.referrer, status: :see_other
  end

  private

  def notify(user, reaction)
    return if current_user == user

    user.notifications.create(notifiable: reaction)
  end
end
