class UsersController < ApplicationController
  def invite
    @user = User.find(params[:id])
    if @user.deliver_invitation
      flash[:success] = "#{@user.person.full_name} wurde eingeladen."
      redirect_to people_path
    else
      flash.now[:error] = "Einladung konnte nicht gesendet werden.\n#{@user.errors.full_messages.join("\n")}"
      render "people/index"
    end
  end
end
