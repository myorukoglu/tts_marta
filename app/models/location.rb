class Location < ApplicationRecord
  geocoded_by :my_location
  after_validation :geocode
  
  validates :address, presence: true
  validates :city, presence: true
  
  def my_location
    "#{address}, #{city}, GA, USA"
  end
end
