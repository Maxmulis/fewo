class CampsController < ApplicationController
  def index
  end

  def show
    @camp = Camp.find(params[:id])
    @registrations = @camp.registrations.includes(:person)
    @people = @registrations.map(&:person)
  end
end
