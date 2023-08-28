class MarketVendorSerializer
  include JSONAPI::Serializer
  attributes :market_id, :vendor_id

  belongs_to :market
  belongs_to :vendor
end
