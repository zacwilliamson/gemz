class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    root_path
  end

  def log_in_user
    return if user_signed_in?

    flash[:alert] = 'Please sign in.'
    redirect_to new_user_registration_path, status: :see_other
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
