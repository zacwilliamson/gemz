class ReactionsController < ApplicationController
  before_action :log_in_user

  def create
    reactable = Post.find(params[:reactable_id])
    Reaction.create(user: current_user, reactable: reactable)
    redirect_to request.referrer
  end

  def destroy
    reaction = current_user.reactions.find(params[:id])
    reaction.destroy
    redirect_to request.referrer, status: :see_other
  end
end
