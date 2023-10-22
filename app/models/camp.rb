class Camp < ApplicationRecord
  belongs_to :place
  has_many :registrations
  has_many :participants, through: :registrations, source: :person
end
