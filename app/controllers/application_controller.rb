class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :set_locale

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def extract_locale
    parsed_locale = params[:locale] || session[:locale] || extract_locale_from_accept_language_header
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
  end

  def user_not_authorized
    flash[:alert] = I18n.t('controllers.application.not_authorized')
    redirect_back(fallback_location: root_path)
  end
end
