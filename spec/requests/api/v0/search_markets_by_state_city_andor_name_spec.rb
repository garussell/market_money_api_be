require 'rails_helper'

describe "Search Markets by State, City, and/or Name" do
  before do
    @markets = create_list(:market, 10)
  end

  context "happy path - valid params" do
    it "is a successful search when parameters are correct" do
      market = @markets.first
      
      # City, State, Name
      get "/api/v0/markets/search", params: { city: market.city, state: market.state, name: market.name } 

      expect(response).to be_successful

      # State
      get "/api/v0/markets/search", params: { state: market.state} 
      expect(response).to be_successful
      
      # City, State
      get "/api/v0/markets/search", params: { city: market.city, state: market.state } 
      expect(response).to be_successful
      
      # State, Name
      get "/api/v0/markets/search", params: { state: market.state, name: market.name } 
      expect(response).to be_successful
      
      # Name
      get "/api/v0/markets/search", params: { name: market.name } 
      expect(response).to be_successful
    end

    it "will always return an array with status code 200 even with zero search results" do
      market = @markets.first

      get "/api/v0/markets/search", params: { city: "Denver", state: "Colorado", name: "Chucks Donuts" } 
  
      expect(response).to be_successful
      market = JSON.parse(response.body, symbolize_names: true)

      expect(market[:data]).to eq([])
    end
  end
  
  context "sad path - invalid params" do
    it "will throw a 422 status code when search params are not valid" do
      market = @markets.last

      # City
      get "/api/v0/markets/search", params: { city: market.city  }
      expect(response).to have_http_status(:unprocessable_entity)

      # City, Name
      get "/api/v0/markets/search", params: { city: market.city, name: market.name } 
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end