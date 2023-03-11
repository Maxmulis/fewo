class Person < ApplicationRecord
  has_many :registrations
  has_many :camps, through: :registrations
  has_many :responsibilities
  has_many :minors, through: :responsibilities, source: :registration

  validates :last_name, uniqueness: { scope: [ :first_name, :dob ], message: "Person already exists" }
  validates_presence_of :last_name, :first_name, :dob, :street, :zip, :city, :country_code

  def minor_during_camp?(camp)
    calculate_age_at_camp_start(camp) < 18
  end

  def age_at_camp_start(camp)
    (camp.startdate - dob).to_i / 365.25
  end

  def age
    ((Date.today - dob).to_i / 365.25).floor
  end

  def minor?
    age < 18
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
