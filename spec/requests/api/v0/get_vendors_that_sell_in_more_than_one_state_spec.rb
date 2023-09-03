require 'rails_helper'

describe "Vendors That Sell In More Than One State" do
  context "happy path" do
    before do
      @vendors = create_list(:vendor, 10)
      @co_markets = create_list(:market, 5, state: 'Colorado')
      @ca_markets = create_list(:market, 5, state: 'California')
      @market_vendors = []
        
      5.times do |i|
        @market_vendors << create(:market_vendor, market: @co_markets[i], vendor: @vendors[i])
      end
    
      5.times do |i|
        @market_vendors << create(:market_vendor, market: @ca_markets[i], vendor: @vendors[i])
      end
    end 

    it "returns a list of vendors that sell as Markets in more than one state" do
      get "/api/v0/vendors/multiple_states"
      expect(response).to be_successful
      vendors = JSON.parse(response.body, symbolize_names: true)
    
      expect(vendors).to have_key(:data)
      expect(vendors[:data]).to be_an(Array)

      expect(vendors[:data][0][:attributes]).to have_key(:states_sold_in)
      expect(vendors[:data][0][:attributes][:states_sold_in]).to be_an(Array)
      expect(vendors[:data][0][:attributes][:states_sold_in].count).to eq(2)
    end
  end

  context "sad path" do
    before do
      @vendors = create_list(:vendor, 10)
      @markets = create_list(:market, 10)
      @market_vendors = []
      10.times do |i|
        @market_vendors << create(:market_vendor, market: @markets[i], vendor: @vendors[i])
      end
    end

    it "does coding on the weekends" do
      get "/api/v0/vendors/multiple_states"

      expect(response).to have_http_status(:not_found)
      error_response = JSON.parse(response.body, symbolize_names: true)
      
      expect(error_response).to have_key(:errors)
      expect(error_response[:errors].first).to have_key(:detail)
      expect(error_response[:errors].first[:detail]).to eq("No Vendors with Multiple States Found")
    end
  end
end