class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'Sie sind nicht berechtigt, diese Aktion durchzuführen.'
    redirect_back(fallback_location: root_path)
  end
end
