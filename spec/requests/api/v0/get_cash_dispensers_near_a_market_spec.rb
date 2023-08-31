require 'rails_helper'

describe "Get Cash Dispensers Near A Market" do
  before do
    @markets = create_list(:market, 10)
  end

  context "happy path - valid market_id" do
    it "returns a list of ATMs near the market" do
      market_id = @markets.first.id
      get "/api/v0/markets/#{market_id}/nearest_atms"

      expect(response).to be_successful
      market = JSON.parse(response.body, symbolize_names: true)

      expect(market).to have_key(:data)
      expect(market[:data]).to be_an(Array)

      expect(market[:data].first).to have_key(:id)
      expect(market[:data].first[:id]).to be nil

      expect(market[:data].first).to have_key(:type)
      expect(market[:data].first[:type]).to be_a(String)

      expect(market[:data].first).to have_key(:attributes)
      expect(market[:data].first[:attributes]).to be_a(Hash)

      expect(market[:data].first[:attributes]).to have_key(:name)
      expect(market[:data].first[:attributes][:name]).to be_a(String)

      expect(market[:data].first[:attributes]).to have_key(:address)
      expect(market[:data].first[:attributes][:address]).to be_a(String)

      expect(market[:data].first[:attributes]).to have_key(:lat)
      expect(market[:data].first[:attributes][:lat]).to be_a(Float)

      expect(market[:data].first[:attributes]).to have_key(:lon)
      expect(market[:data].first[:attributes][:lon]).to be_a(Float)

      expect(market[:data].first[:attributes]).to have_key(:distance)
      expect(market[:data].first[:attributes][:distance]).to be_a(Float)
    end
  end

  context "sad path - invalid market_id" do
    it "throws an error if the market_id is not valid" do
      invalid_id = "123123123123"
      get "/api/v0/markets/#{invalid_id}/nearest_atms"

      expect(response).to have_http_status(:not_found)
      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response).to have_key(:errors)
      expect(error_response[:errors].first).to have_key(:detail)
      expect(error_response[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=#{invalid_id}")
    end
  end
end