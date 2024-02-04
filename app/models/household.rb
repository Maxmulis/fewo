class Household < ApplicationRecord
  has_many :people, dependent: :nullify
end
