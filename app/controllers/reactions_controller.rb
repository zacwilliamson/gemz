class ReactionsController < ApplicationController
  before_action :log_in_user

  def create
    @reaction = current_user.reactions.build(reaction_params)
    # notify post user
    redirect_to request.referrer
  end

  def destroy
    @reaction = current_user.reactions.find(params[id])
    redirect_to request.referrer, status: :see_other
  end

  private
  
  def reaction_params
    params.require(:reaction).permit(:reactionable_id, :reactionable_type)
  end
end
