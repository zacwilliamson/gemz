class UsersController < ApplicationController
  before_action :set_user, only: %i[show friends]
  before_action :log_in_user, only: %i[show friends]
  def show; end

  def friends
    @friends = @user.active_friends
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
