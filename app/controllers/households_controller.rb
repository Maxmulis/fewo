class HouseholdsController < ApplicationController
  def index
    authorize Household
    @households = Household.includes(:people)
  end

  def show
    @household = Household.preload(:people).find(params[:id])
    authorize @household
  end

  def new
    @household = Household.new
    authorize @household
    @similar_households = []

    if params[:household].present? && params[:household][:street].present?
      @household.assign_attributes(household_params)
      @similar_households = Household.find_similar(
        street: params[:household][:street],
        number: params[:household][:number],
        zip_code: params[:household][:zip_code],
        town: params[:household][:town],
        country_code: params[:household][:country_code]
      )
    end
  end

  def edit
    @household = Household.find(params[:id])
    authorize @household
    @people = @household.people
  end

  def update
    @household = Household.find(params[:id])
    authorize @household
    if @household.update(household_params)
      flash[:success] = t('controllers.households.update.success')
      redirect_to edit_household_path(@household)
    else
      @people = @household.people
      flash.now[:alert] = @household.errors.full_messages.join(', ')
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @household = Household.new(household_params)
    authorize @household
    @similar_households = Household.find_similar(
      street: @household.street,
      number: @household.number,
      zip_code: @household.zip_code,
      town: @household.town,
      country_code: @household.country_code
    )

    if @household.save
      flash[:success] = t('controllers.households.create.success')
      redirect_to @household
    else
      flash.now[:alert] = @household.errors.full_messages.join(', ')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def household_params
    params.require(:household).permit(:street, :zip_code, :number, :country_code, :town, :recipient)
  end
end
