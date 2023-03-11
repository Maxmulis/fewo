class Person < ApplicationRecord
  has_many :registrations
  has_many :camps, through: :registrations
  has_many :responsibilities
  has_many :minors, through: :responsibilities, source: :registration

  def minor_during_camp?(camp)
    calculate_age_at_camp_start(camp) < 18
  end

  def calculate_age_at_camp_start(camp)
    (camp.startdate - dob).to_i / 365.25
  end
end
