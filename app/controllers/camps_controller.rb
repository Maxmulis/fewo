class CampsController < ApplicationController
  def index
    authorize Camp
    @camps = Camp.includes(:place).order(start_date: :desc)
  end

  def show
    @camp = Camp.find(params[:id])
    authorize @camp
    @registrations = @camp.registrations.includes(:person)
    @people = @registrations.map(&:person)
    @households = Household.includes(:people)
  end

  def new
    @camp = Camp.new
    authorize @camp
    @places = Place.all
  end

  def create
    @camp = Camp.new(camp_params)
    authorize @camp
    if @camp.save
      redirect_to @camp, notice: t('controllers.camps.create.success')
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
