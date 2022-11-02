class ProfilesController < ApplicationController
  def new
    @profile = current_user.build_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      flash[:notice] = 'Your profile was created'
      redirect_to current_user
    else
      redirect_to current_user, status: :unprocessable_entity
    end
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      flash[:notice] = 'Your profile was updated'
      redirect_to @profile.user
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  def edit; end

  private

  def profile_params
    params.require(:profile).permit(:full_name, :location, :link, :bio)
  end
end
