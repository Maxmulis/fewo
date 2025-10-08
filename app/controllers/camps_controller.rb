class CampsController < ApplicationController
  def index; end

  def show
    @camp = Camp.find(params[:id])
    @registrations = @camp.registrations.includes(:person)
    @people = @registrations.map(&:person)
    @households = Household.includes(:people)
  end

  def new
    @camp = Camp.new
    @places = Place.all
  end

  def create
    @camp = Camp.new(camp_params)
    if @camp.save
      redirect_to @camp, notice: 'Camp was successfully created.'
    else
      @places = Place.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def camp_params
    params.require(:camp).permit(:start_date, :end_date, :place_id)
  end
end
