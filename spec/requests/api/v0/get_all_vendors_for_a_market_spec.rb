require 'rails_helper'

describe "Get All Vendors For A Market" do
  before do
    markets = create_list(:market, 10)
    vendors = create_list(:vendor, 10)

    market_vendors = []
    10.times do |i|
      market_vendors << create(:market_vendor, market: markets[i], vendor: vendors[i])
    end

    @valid_id = markets.sample.id
  end

  context "happy path - valid market id" do
    it "returns all of the individual market's vendors" do
      get "/api/v0/markets/#{@valid_id}/vendors"

      expect(response).to be_successful

      vendors = JSON.parse(response.body, symbolize_names: true)

      expect(vendors[:data].first).to have_key(:type)
      expect(vendors[:data].first[:type]).to be_a(String)

      expect(vendors[:data].first[:attributes]).to have_key(:name)
      expect(vendors[:data].first[:attributes][:name]).to be_a(String)

      expect(vendors[:data].first[:attributes]).to have_key(:description)
      expect(vendors[:data].first[:attributes][:description]).to be_a(String)

      expect(vendors[:data].first[:attributes]).to have_key(:contact_name)
      expect(vendors[:data].first[:attributes][:contact_name]).to be_a(String)

      expect(vendors[:data].first[:attributes]).to have_key(:contact_phone)
      expect(vendors[:data].first[:attributes][:contact_phone]).to be_a(String)

      expect(vendors[:data].first[:attributes]).to have_key(:credit_accepted)
      expect(vendors[:data].first[:attributes][:credit_accepted]).to be_a(TrueClass).or be_a(FalseClass)
    end
  end

  context "sad path - invalid market id" do
    it "returns an error if ID is not valid" do
      invalid_id = "123123123123"
      get "/api/v0/markets/#{invalid_id}/vendors"

      expect(response).to have_http_status(:not_found)
      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response).to have_key(:errors)
      expect(error_response[:errors].first).to have_key(:detail)
      expect(error_response[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=#{invalid_id}")
    end
  end
end