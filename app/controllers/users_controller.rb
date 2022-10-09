class UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  before_action :log_in_user, only: %i[show]
  def show; end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
