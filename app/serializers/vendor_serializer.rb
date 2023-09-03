class VendorSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :contact_name, :contact_phone, :credit_accepted, :states_sold_in
  set_type :vendor

  has_many :market_vendors
  has_many :markets, through: :market_vendors
end
