class Market < ApplicationRecord
  validates_presence_of :name, :street, :city, :county, :state, :zip, :lat, :lon, :vendor_count

  has_many :market_vendors
  has_many :vendors, through: :market_vendors


  def self.vendors_per_state
    select('markets.state, COUNT(market_vendors.id) AS number_of_vendors')
      .joins(:market_vendors)
      .group('markets.state')
  end
end