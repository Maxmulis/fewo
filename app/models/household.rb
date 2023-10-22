class Household < ApplicationRecord
  belongs_to :address
  has_many :people, dependent: :nullify
end
