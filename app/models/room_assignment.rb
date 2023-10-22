class RoomAssignment < ApplicationRecord
  belongs_to :person
  belongs_to :camp
  belongs_to :room
end
