class Registration < ApplicationRecord
  belongs_to :person
  belongs_to :camp

  validates_uniqueness_of :person, scope: :camp
  validate :person_has_household
  validate :underage_requires_adult_household_member
  validate :arrival_date_before_departure

  private

  def person_has_household
    unless person.household
      errors.add(:person, "must belong to a household to register for a camp.")
    end
  end

  def underage_requires_adult_household_member
    if person.underage_at_camp?(camp) && !adult_household_member_registered?
      errors.add(:person, "requires an adult member of the household to be already registered if underage.")
    end
  end

  def arrival_date_before_departure
    if arrival_date && departure_date && arrival_date >= departure_date
      errors.add(:departure_date, "must be after arrival date.")
    end
  end

  def adult_household_member_registered?
    person.household.people.any? { |household_member| household_member.adult_at_camp?(camp) && household_member.registered_for?(camp) }
  end
end
