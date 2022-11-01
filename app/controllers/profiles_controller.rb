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

  def edit; end

  def update; end

  private

  def profile_params
    params.require(:profile).permit(:full_name, :location, :link, :bio)
  end
end
