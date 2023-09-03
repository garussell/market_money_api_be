require 'rails_helper'

describe "Get Vendors That Sell in a Particular State" do
  before do
    vendors = create_list(:vendor, 10)
    co_markets = create_list(:market, 5, state: 'Colorado')
    ca_markets = create_list(:market, 7, state: 'California')
    az_markets = create_list(:market, 9, state: 'Arizona')

    market_vendors = []
    5.times do |i|
      market_vendors << create(:market_vendor, market: co_markets[i], vendor: vendors[i])
    end
    7.times do |i|
      market_vendors << create(:market_vendor, market: ca_markets[i], vendor: vendors[i])
    end
    9.times do |i|
      market_vendors << create(:market_vendor, market: az_markets[i], vendor: vendors[i])
    end
  end

  context "happy path" do
    it "returns a list of vendors that sell in a selected state" do
      get "/api/v0/vendors/search_by_state", params: { state: "Arizona" }

      expect(response).to be_successful
      vendors = JSON.parse(response.body, symbolize_names: true)
      
      expect(vendors).to have_key(:data)
      expect(vendors[:data]).to be_an(Array)

      expect(vendors[:data][0]).to have_key(:id)
      expect(vendors[:data][0][:id]).to be_a(String)

      expect(vendors[:data][0]).to have_key(:type)    
      expect(vendors[:data][0][:type]).to be_a(String)
  
      expect(vendors[:data][0]).to have_key(:attributes)    
      expect(vendors[:data][0][:attributes]).to be_a(Hash)

      expect(vendors[:data][0][:attributes]).to have_key(:name)    
      expect(vendors[:data][0][:attributes][:name]).to be_a(String)

      expect(vendors[:data][0][:attributes]).to have_key(:description)    
      expect(vendors[:data][0][:attributes][:description]).to be_a(String)
    
      expect(vendors[:data][0][:attributes]).to have_key(:contact_name)    
      expect(vendors[:data][0][:attributes][:contact_name]).to be_a(String)
   
      expect(vendors[:data][0][:attributes]).to have_key(:contact_phone)    
      expect(vendors[:data][0][:attributes][:contact_phone]).to be_a(String)

      expect(vendors[:data][0][:attributes]).to have_key(:credit_accepted)    
      expect(vendors[:data][0][:attributes][:credit_accepted]).to be_a(TrueClass).or be_a(FalseClass)
   
      expect(vendors[:data][0][:attributes]).not_to have_key(:states_sold_in)    
    end
  end

  context "sad path" do
    it "throws an error if there are no vendors in that state" do
      get "/api/v0/vendors/search_by_state", params: { state: "Texas" }

      expect(response).to have_http_status(:not_found)
      error_response = JSON.parse(response.body, symbolize_names: true)
    
      expect(error_response).to have_key(:errors)
      expect(error_response[:errors].first).to have_key(:detail)
      expect(error_response[:errors].first[:detail]).to eq("Couldn't find a Vender in Texas")
    end
  end
end