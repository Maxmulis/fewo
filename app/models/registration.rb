class Registration < ApplicationRecord
  belongs_to :camp
  belongs_to :room, optional: true
  belongs_to :person
  has_many :responsibilities
  has_many :responsibles, through: :responsibilities, source: :person

  # validate :has_responsible, if: :minor?

  private

  def minor?
    person.minor_during_camp?(camp)
  end
  
  def has_responsible
    return if responsibles.present?
    errors.add(:base, "A minor must have at least one responsible person")
  end

  def has_responsible?
    responsibles.present?
  end

  def has_no_responsible?
    !has_responsible?
  end
end
