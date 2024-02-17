class HouseholdsController < ApplicationController
  
  def index
    @households = Household.includes(:people)
  end
  def show
    @household = Household.preload(:people).find(params[:id])
  end
  
  def new
    @household = Household.new
  end

  def edit
  end

  def create
    @household = Household.new(household_params)
    if @household.save
      redirect_to @household
    else
      render :new
    end
  end

  private

  def household_params
    params.require(:household).permit(:street, :zip_code, :number, :country_code, :town, :recipient)
  end

end
