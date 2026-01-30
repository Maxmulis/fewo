class RegistrationsController < ApplicationController
  def index
    authorize Registration
  end

  def new
    @camp = Camp.find(params[:camp_id])
    @registration = Registration.new(camp: @camp)
    authorize @registration

    # all people that are not already registered for the camp
    @people = Person.where.not(
      id: Registration.select(:person_id).where(camp_id: @camp.id)
    )
  end

  def create
    camp = Camp.find(params[:camp_id])
    registration = Registration.new(registration_params)
    registration.camp = camp
    authorize registration

    ActiveRecord::Base.transaction do
      if registration.save
        if params[:registration][:make_team_member] == '1' && current_user.admin?
          person = registration.person
          if person.user
            CampTeamMember.create!(camp: camp, user: person.user)
          end
        end
        flash[:success] = t('controllers.registrations.create.success')
        redirect_to camp_path(camp)
      else
        flash.now[:error] = t('controllers.registrations.create.error')
        redirect_to request.referer
      end
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:person_id, :arrival_date, :departure_date)
  end
end
