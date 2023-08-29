require 'rails_helper'

describe "Get All Vendors For A Market" do
  before do
    markets = create_list(:market, 10)
    @valid_id = markets.sample.id
  end

  context "happy path - valid market id" do
    it "returns all of the individual market's vendors" do
      get "/api/v0/markets/#{@valid_id}"

      expect(response).to be_successful

      vendors = JSON.parse(response.body, symbolize_names: true)

      expect(vendors[:data][:attributes]).to have_key(:vendor_count)
      expect(vendors[:data][:attributes][:vendor_count]).to be_a(Integer)
    end
  end
end