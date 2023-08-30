require 'rails_helper'

describe "Create A MarketVendor" do
  before do
    @market = create(:market)
    @vendor = create(:vendor)
  end
  
  context "happy path" do
    it "successfully added vendor to market" do
      post "/api/v0/market_vendors", params: { market_vendor: { market_id: @market.id, vendor_id: @vendor.id } }

      expect(response).to have_http_status(:created)
      market_vendor = JSON.parse(response.body, symbolize_names: true)

      expect(market_vendor[:data]).to have_key(:id)
      expect(market_vendor[:data][:id]).to be_a(String)
      
      expect(market_vendor[:data]).to have_key(:type)
      expect(market_vendor[:data][:type]).to be_a(String)
      
      expect(market_vendor[:data][:attributes]).to have_key(:market_id)
      expect(market_vendor[:data][:attributes][:market_id]).to be_an(Integer)
      
      expect(market_vendor[:data][:attributes]).to have_key(:vendor_id)
      expect(market_vendor[:data][:attributes][:vendor_id]).to be_an(Integer)
      
      # Verify the association
      get "/api/v0/markets/#{@market.id}/vendors"
      expect(response).to be_successful

      vendors = JSON.parse(response.body, symbolize_names: true)
      expect(vendors[:data].first[:id].to_i).to eq(@vendor.id)
    end
  end

  context "sad path" do
    it "throws an error when market_id or vendor_id is invalid" do
      invalid_id = "123123123"

      post "/api/v0/market_vendors", params: { market_vendor: { market_id: @market.id, vendor_id: invalid_id } }

      expect(response).to have_http_status(:not_found)
      
      post "/api/v0/market_vendors", params: { market_vendor: { market_id: invalid_id, vendor_id: @vendor.id } }
      
      expect(response).to have_http_status(:not_found)
    end

    it "throws an error when the market vendor association already exhists" do
      create(:market_vendor, market: @market, vendor: @vendor)
     
      post "/api/v0/market_vendors", params: { market_vendor: { market_id: @market.id, vendor_id: @vendor.id } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end