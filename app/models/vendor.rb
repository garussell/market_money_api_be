class Vendor < ApplicationRecord
  validates_presence_of :name, 
                        :description, 
                        :contact_name, 
                        :contact_phone 
                        
  validates :credit_accepted, inclusion: { in: [true, false]}

  has_many :market_vendors
  has_many :markets, through: :market_vendors


  def self.multiple_states
    joins(:markets)
      .group('vendors.id')
      .select('vendors.*, COUNT(DISTINCT markets.state) AS state_count')
      .having('COUNT(DISTINCT markets.state) > 1')
      .order('state_count DESC')
      .to_a
  end

  def states_sold_in
    markets.distinct.pluck(:state)
  end
end