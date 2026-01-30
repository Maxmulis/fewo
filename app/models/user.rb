class User < ApplicationRecord
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :validatable
  belongs_to :person
  has_many :camp_team_members, dependent: :destroy
  has_many :team_camps, through: :camp_team_members, source: :camp

  def admin?
    admin
  end

  def team_member?
    camp_team_members.any?
  end

  def team_member_for?(camp)
    team_camps.include?(camp)
  end

  def role
    return :admin if admin?
    return :team_member if team_member?
    :participant
  end
end
