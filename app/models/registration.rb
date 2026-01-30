class Registration < ApplicationRecord
  belongs_to :person
  belongs_to :camp

  validates_uniqueness_of :person, scope: :camp
  validate :person_has_household
  validate :underage_requires_adult_household_member
  validate :arrival_date_before_departure

  after_destroy :destroy_household_registrations_if_no_adults
  after_initialize :set_default_dates

  private

  def set_default_dates
    self.arrival_date = Camp.next.start_date
    self.departure_date = Camp.next.end_date
  end

  def destroy_household_registrations_if_no_adults
    household = person.household
    camp_registrations = Registration.where(camp: camp, person: household.people)

    return unless camp_registrations.none? { |registration| registration.person.adult_at_camp?(camp) }

    camp_registrations.destroy_all
  end

  def person_has_household
    return if person.household

    errors.add(:person, I18n.t('activerecord.errors.models.registration.attributes.person.household_required'))
  end

  def underage_requires_adult_household_member
    return unless person.underage_at_camp?(camp) && !adult_household_member_registered?

    errors.add(:person, I18n.t('activerecord.errors.models.registration.attributes.person.adult_required'))
  end

  def arrival_date_before_departure
    return unless arrival_date && departure_date && arrival_date >= departure_date

    errors.add(:departure_date, I18n.t('activerecord.errors.models.registration.attributes.departure_date.after_arrival'))
  end

  def adult_household_member_registered?
    person.household.people.any? do |household_member|
      household_member.adult_at_camp?(camp) && household_member.registered_for?(camp)
    end
  end
end
