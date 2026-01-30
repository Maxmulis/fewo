class DashboardController < ApplicationController
  def index
    case current_user.role
    when :admin
      render 'admin'
    when :team_member
      render 'team_member'
    else
      render 'participant'
    end
  end
end
