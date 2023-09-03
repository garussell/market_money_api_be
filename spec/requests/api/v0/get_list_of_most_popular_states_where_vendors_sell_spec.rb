require 'rails_helper'

describe "List of Most Popular States Where Vendors Sell" do
  before do
    vendors = create_list(:vendor, 10)
    co_markets = create_list(:market, 10, state: 'Colorado')
    ca_markets = create_list(:market, 10, state: 'California')
    az_markets = create_list(:market, 10, state: 'Arizona')

    market_vendors = []
    10.times do |i|
      market_vendors << create(:market_vendor, market: co_markets[i], vendor: vendors[i])
    end
    10.times do |i|
      market_vendors << create(:market_vendor, market: ca_markets[i], vendor: vendors[i])
    end
    10.times do |i|
      market_vendors << create(:market_vendor, market: az_markets[i], vendor: vendors[i])
    end
  end

  context "happy path" do
    it "responds with a lot of popular states and number_of_vendors per state" do
      get "/api/v0/vendors/popular_states" 
      expect(response).to be_successful
      
      states = JSON.parse(response.body, symbolize_names: true)

      expect(states).to have_key(:data)
      expect(states[:data]).to be_an(Array)

      expect(states[:data][0]).to have_key(:state)
      expect(states[:data][0][:state]).to be_a(String)

      expect(states[:data][0]).to have_key(:number_of_vendors)
      expect(states[:data][0][:number_of_vendors]).to be_an(Integer)
    end
  end
end