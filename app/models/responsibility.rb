class Responsibility < ApplicationRecord
  belongs_to :person
  belongs_to :registration

  # Person must be at least 18 years old and registered for the camp.

  validate :person_is_adult
  validate :person_is_registered_for_camp

  private

  def person_is_adult?
    !person.minor_during_camp?(registration.camp)
  end

  def person_is_registered_for_camp?
    person.camps.include?(registration.camp)
  end

  def person_is_adult
    return if person_is_adult?
    errors.add(:base, "A responsible person must be at least 18 years old")
  end

  def person_is_registered_for_camp
    return if person_is_registered_for_camp?
    errors.add(:base, "A responsible person must be registered for the camp")
  end
end
