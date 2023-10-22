class Camp < ApplicationRecord
  belongs_to :place
  has_many :participants, through: :registrations
end
