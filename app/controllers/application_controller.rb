# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?

  wrap_parameters format: [:json]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[email password password_confirmation first_name last_name bio username
                                               profile_picture])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[first_name last_name bio username profile_picture])
  end

  # Disable CSRF for API-only applications
  # protect_from_forgery with: :null_session
end
