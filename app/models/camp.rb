class Camp < ApplicationRecord
  belongs_to :place
  has_many :registrations
  has_many :participants, through: :registrations, source: :person
  has_many :camp_team_members, dependent: :destroy
  has_many :team_members, through: :camp_team_members, source: :user

  def self.next
    order(:start_date).first
  end

  def year
    start_date.year
  end
end
