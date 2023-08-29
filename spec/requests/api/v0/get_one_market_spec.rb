require 'rails_helper'

describe "Get One Market" do
  context "happy path - valid market id" do
    before do
      markets = create_list(:market, 10)
      @market_id = markets.sample.id
    end

    it "returns one market based on ID search" do
      get "/api/v0/markets/#{@market_id}"

      expect(response).to be_successful

      market = JSON.parse(response.body, symbolize_names: true)

      expect(market.count).to eq(1)

      expect(market[:data][:attributes]).to have_key(:id)
      expect(market[:data][:attributes][:id]).to be_an(Integer)
      expect(market[:data][:attributes]).to have_key(:name)
      expect(market[:data][:attributes][:name]).to be_a(String)
      
      expect(market[:data][:attributes]).to have_key(:street)
      expect(market[:data][:attributes][:street]).to be_a(String)
      
      expect(market[:data][:attributes]).to have_key(:city)
      expect(market[:data][:attributes][:city]).to be_a(String)
      
      expect(market[:data][:attributes]).to have_key(:county)
      expect(market[:data][:attributes][:county]).to be_a(String)
      
      expect(market[:data][:attributes]).to have_key(:state)
      expect(market[:data][:attributes][:state]).to be_a(String)
      
      expect(market[:data][:attributes]).to have_key(:zip)
      expect(market[:data][:attributes][:zip]).to be_a(String)
      
      expect(market[:data][:attributes]).to have_key(:lat)
      expect(market[:data][:attributes][:lat]).to be_a(String)
      
      expect(market[:data][:attributes]).to have_key(:lon)
      expect(market[:data][:attributes][:lon]).to be_a(String)
    end
  end

  context "sad path - invalid ID" do
    it "returns an error if ID is not valid" do
      
    end
  end
end