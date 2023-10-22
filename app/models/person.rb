class Person < ApplicationRecord
  belongs_to :household
  has_many :camps, through: :registrations

  def age_at_camp(camp)
    ((camp.start_date - dob) / 365.25).floor
  end

  def underage_at_camp?(camp)
    age_at_camp(camp) < 18
  end

  def adult_at_camp?(camp)
    !underage_at_camp?(camp)
  end

  def registered_for_camp?(camp)
    camps.include?(camp)
  end

end
