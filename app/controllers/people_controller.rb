class PeopleController < ApplicationController
  def index
    @people = Person.all.order(name: :asc)
  end

  def new
    @person = Person.new
    @household = Household.find(params[:household_id])
  end

  def create
    @person = Person.new(person_params)
    @person.household = Household.find(params[:household_id])
    if @person.save
      flash[:success] = "#{@person.full_name} wurde gespeichert."
      redirect_to households_path
    else
      flash.now[:error] = "Person konnte nicht gespeichert werden.\n#{@person.errors.full_messages.join("\n")}"
      render :new
    end
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    if @person.update(person_params)
      flash[:success] = "#{@person.full_name} wurde gespeichert."
      redirect_to people_path
    else
      flash.now[:error] = "Person konnte nicht gespeichert werden.\n#{@person.errors.full_messages.join("\n")}"
      render :edit
    end
  end

  private

  def person_params
    params.require(:person).permit(:first_name, :name, :dob)
  end
end
