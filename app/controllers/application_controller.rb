class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  private

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
    return unless params[:locale] && I18n.available_locales.include?(params[:locale].to_sym)

    I18n.locale = params[:locale]
    session[:locale] = I18n.locale
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
