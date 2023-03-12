class RegistrationsController < ApplicationController
  def index
  end

  def create
    camp = Camp.find(params[:camp_id])
    person = Person.find(params[:person_id])
    registration = camp.registrations.build(person: person)
    if registration.save
      flash[:success] = "Registration created."
      redirect_to camp_path(camp)
    else
      flash.now[:error] = "Registration could not be created."
      rendirect_to request.referer
    end
  end
end
