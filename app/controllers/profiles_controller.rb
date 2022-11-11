class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[update]

  def update
    if @profile.update(profile_params)
      attach_img
      flash[:notice] = 'Your profile was updated'
      redirect_to @profile.user
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  def edit; end

  private

  def attach_img
    return if params[:profile][:image].nil?

    @profile.image.attach(params[:profile][:image])
  end

  def profile_params
    params.require(:profile).permit(:full_name, :location, :link, :bio, :image)
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end
end
