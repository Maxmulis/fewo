class PeopleController < ApplicationController
  def index
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      redirect_to people_path
    else
      render :new
    end
  end

  private

  def person_params
    params.require(:person).permit(:last_name, :first_name, :dob, :street, :zip, :city, :country_code, :phone, :email)
  end
end
