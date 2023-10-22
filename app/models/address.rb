class Address < ApplicationRecord
  validates :street, uniqueness: { scope: [:zip_code, :number, :country_code, :town],
                                  message: 'Address must be unique across all fields' }
end
