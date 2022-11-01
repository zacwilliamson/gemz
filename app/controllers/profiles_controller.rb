class ProfilesController < ApplicationController
  def new
    @profile = current_user.build_profile
  end

  def create; end

  def edit; end

  def update; end
end
