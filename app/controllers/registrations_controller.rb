class RegistrationsController < ApplicationController
  def index; end

  def new
    @camp = Camp.find(params[:camp_id])
    @registration = Registration.new(camp: @camp)

    # all people that are not already registered for the camp
    @people = Person.where.not(
      id: Registration.select(:person_id).where(camp_id: @camp.id)
    )
  end

  def create
    camp = Camp.find(params[:camp_id])
    registration = Registration.new(registration_params)
    registration.camp = camp
    if registration.save
      flash[:success] = 'Registration created.'
      redirect_to camp_path(camp)
    else
      flash.now[:error] = 'Registration could not be created.'
      redirect_to request.referer
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:person_id, :arrival_date, :departure_date)
  end
end
