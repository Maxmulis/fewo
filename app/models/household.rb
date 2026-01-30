class Household < ApplicationRecord
  has_many :people, dependent: :nullify

  validates :street, presence: true
  validates :number, presence: true
  validates :zip_code, presence: true, format: { with: /\A[0-9]{4,10}\z/ }
  validates :town, presence: true
  validates :country_code, presence: true, format: { with: /\A[A-Z]{2}\z/ }
  validates :recipient, presence: true

  validates :street, uniqueness: { scope: [:number, :zip_code, :town, :country_code, :recipient] }

  before_validation :normalize_country_code

  def self.find_similar(street:, number:, zip_code:, town:, country_code:)
    normalized_country = country_code&.upcase

    where(
      "LOWER(street) = ? AND LOWER(number) = ? AND zip_code = ? AND LOWER(town) = ? AND country_code = ?",
      street&.downcase,
      number&.downcase,
      zip_code,
      town&.downcase,
      normalized_country
    )
  end

  def full_address
    "#{street} #{number}, #{zip_code} #{town}, #{country_code}"
  end

  private

  def normalize_country_code
    self.country_code = country_code&.upcase
  end
end
