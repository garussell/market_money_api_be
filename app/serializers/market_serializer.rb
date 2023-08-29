class MarketSerializer
  include JSONAPI::Serializer
  attributes :name, :street, :city, :county, :state, :zip, :lat, :lon

  has_many :market_vendors
  has_many :vendors, through: :market_vendors

  attribute :vendor_count do |object|
    object.vendors.count
  end
end
