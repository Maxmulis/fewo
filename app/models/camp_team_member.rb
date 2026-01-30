class CampTeamMember < ApplicationRecord
  belongs_to :user
  belongs_to :camp

  validates :user_id, uniqueness: { scope: :camp_id }
end
