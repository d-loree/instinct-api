class ApplicationController < ActionController::API
    before_action :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?

    wrap_parameters format: [:json]
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :first_name, :last_name, :bio, :username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :bio, :username])
    end
  
    # Disable CSRF for API-only applications
    # protect_from_forgery with: :null_session

end  