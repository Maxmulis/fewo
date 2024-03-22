class Person < ApplicationRecord
  belongs_to :household, optional: true
  has_many :registrations
  has_many :camps, through: :registrations
  has_one :user

  validates :first_name, :name, :dob, presence: true
  validates :first_name, :name, uniqueness: { scope: :dob }

  def full_name
    "#{first_name} #{name}"
  end

  def age_at_camp(camp)
    ((camp.start_date - dob) / 365.25).floor
  end

  def underage_at_camp?(camp)
    age_at_camp(camp) < 18
  end

  def adult_at_camp?(camp)
    !underage_at_camp?(camp)
  end

  def registered_for?(camp)
    camps.include?(camp)
  end

end
