class PeopleController < ApplicationController
  def index
    @people = Person.includes(:registrations, :responsibilities).order(last_name: :asc)
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      flash[:success] = "#{@person.full_name} wurde gespeichert."
      redirect_to people_path
    else
      flash.now[:error] = "Person konnte nicht gespeichert werden.\n#{@person.errors.full_messages.join("\n")}"
      render :new
    end
  end

  private

  def person_params
    params.require(:person).permit(:last_name, :first_name, :dob, :street, :zip, :city, :country_code, :phone, :email)
  end
end
