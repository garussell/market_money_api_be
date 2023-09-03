class Vendor < ApplicationRecord
  validates_presence_of :name, 
                        :description, 
                        :contact_name, 
                        :contact_phone 
                        
  validates :credit_accepted, inclusion: { in: [true, false]}

  has_many :market_vendors
  has_many :markets, through: :market_vendors

  def states_sold_in
    markets.distinct.pluck(:state)
  end
end