require 'rails_helper'

describe "Delete A MarketVendor" do
  before do
    markets = create_list(:market, 5)
    vendors = create_list(:vendor, 5)

    @market_vendors = []
    5.times do |i|
      @market_vendors << create(:market_vendor, market: markets[i], vendor: vendors[i])
    end
  end

  context "happy path" do
    it "successfully destroys a MarketVendor" do
      market_id = @market_vendors.first.market_id
      vendor_id = @market_vendors.first.vendor_id
      
      expect(MarketVendor.count).to eq(5)
      
      delete "/api/v0/market_vendors", params: { market_vendor: { market_id: market_id, vendor_id: vendor_id } }

      expect(response).to have_http_status(:no_content)
      expect(MarketVendor.exists?(@market_vendors.first.id)).to be false
      expect(MarketVendor.count).to eq(4)
    end
  end

  context "sad path" do
    it "will throw an error if the association does not exist" do
      market = create(:market)
      vendor = create(:vendor)

      delete "/api/v0/market_vendors", params: { market_vendor: { market_id: market.id, vendor_id: vendor.id } }

      expect(response).to have_http_status(:not_found)
    end
  end
end