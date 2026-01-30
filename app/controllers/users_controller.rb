class UsersController < ApplicationController
  def invite
    @user = User.find(params[:id])
    authorize @user
    if @user.deliver_invitation
      flash[:success] = t('controllers.users.invite.success')
      redirect_to people_path
    else
      flash.now[:error] = t('controllers.users.invite.error')
      render 'people/index'
    end
  end
end
