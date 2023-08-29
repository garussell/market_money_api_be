require 'rails_helper'

describe "Get One Market" do
  context "happy path - valid market id" do
    before do
      markets = create_list(:market, 10)
      @valid_id = markets.sample.id
    end

    it "returns one market based on ID search" do
      get "/api/v0/markets/#{@valid_id}"

      expect(response).to be_successful

      market = JSON.parse(response.body, symbolize_names: true)

      expect(market.count).to eq(1)

      expect(market[:data]).to have_key(:id)
      expect(market[:data][:id]).to be_an(String)
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

      expect(market[:data][:attributes]).to have_key(:vendor_count)
      expect(market[:data][:attributes][:vendor_count]).to be_an(Integer)
    end
  end

  context "sad path - invalid ID" do
    it "returns an error if ID is not valid" do
      invalid_id = "123123123123"
      get "/api/v0/markets/#{invalid_id}"

      expect(response).to have_http_status(:not_found)
      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response).to have_key(:errors)
      expect(error_response[:errors].first).to have_key(:detail)
      expect(error_response[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=#{invalid_id}")
    end
  end
end