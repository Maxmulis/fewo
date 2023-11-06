class Camp < ApplicationRecord
  belongs_to :place
  has_many :registrations
  has_many :participants, through: :registrations, source: :person

  def self.next
    order(:start_date).first
  end

  def year
    start_date.year
  end
end
