class ReactionsController < ApplicationController
  before_action :log_in_user
  before_action :set_reactable, only: %i[create]

  def create
    reaction = current_user.reactions.create(reactable: @reactable)
    notify(@reactable.user, reaction)
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.turbo_stream
    end
  end

  def destroy
    reaction = current_user.reactions.find(params[:id])
    @reactable = reaction.reactable
    reaction.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, status: :see_other }
      format.turbo_stream
    end
  end

  private

  def reaction_params
    params.require(:reaction).permit(:reactable_id, :reactable_type)
  end

  def set_reactable
    @reactable = reaction_params[:reactable_type].constantize.find(reaction_params[:reactable_id])
  end

  def notify(user, reaction)
    return if current_user == user || reaction.reactable_type == 'Comment'

    user.notifications.create(notifiable: reaction)
  end
end
