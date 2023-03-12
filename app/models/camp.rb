class Camp < ApplicationRecord
  has_many :registrations
  has_many :people, through: :registrations

  def self.next
    Camp.where('startdate > ?', Date.today).order('startdate ASC').first
  end

  def year
    startdate.year
  end
end
