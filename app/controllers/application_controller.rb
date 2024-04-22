class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale_and_save_on_session

  private

  def set_locale_and_save_on_session
    I18n.locale = session[:locale] || I18n.default_locale
    if params[:locale]
      I18n.locale = params[:locale]
      session[:locale] = I18n.locale
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end
end
