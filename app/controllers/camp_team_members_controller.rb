class CampTeamMembersController < ApplicationController
  before_action :set_camp

  def create
    @camp_team_member = @camp.camp_team_members.build(camp_team_member_params)
    authorize @camp_team_member

    if @camp_team_member.save
      redirect_to @camp, notice: 'Teammitglied wurde erfolgreich hinzugefügt.'
    else
      redirect_to @camp, alert: 'Teammitglied konnte nicht hinzugefügt werden.'
    end
  end

  def destroy
    @camp_team_member = @camp.camp_team_members.find(params[:id])
    authorize @camp_team_member

    @camp_team_member.destroy
    redirect_to @camp, notice: 'Teammitglied wurde entfernt.'
  end

  private

  def set_camp
    @camp = Camp.find(params[:camp_id])
  end

  def camp_team_member_params
    params.require(:camp_team_member).permit(:user_id)
  end
end
