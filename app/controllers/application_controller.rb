class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale


  protected

  def set_locale
    I18n.available_locales = [:de]
    I18n.locale = :de
  end

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit(:account_update, keys: update_attrs)
    devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
  end
end
