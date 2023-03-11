class Camp < ApplicationRecord
  has_many :registrations
  has_many :people, through: :registrations
end
