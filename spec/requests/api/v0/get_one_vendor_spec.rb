require 'rails_helper'

describe "Get One Vendor" do
  before do
    vendors = create_list(:vendor, 10)
    @valid_id = vendors.sample.id
  end

  context "happy path - get one vendor by ID" do
    it "returns one vendor with valid ID" do
      get "/api/v0/vendors/#{@valid_id}"

      expect(response).to be_successful
    
      vendor = JSON.parse(response.body, symbolize_names: true)

      expect(vendor[:data]).to have_key(:type)
      expect(vendor[:data][:type]).to be_a(String)

      expect(vendor[:data][:attributes]).to have_key(:name)
      expect(vendor[:data][:attributes][:name]).to be_a(String)

      expect(vendor[:data][:attributes]).to have_key(:description)
      expect(vendor[:data][:attributes][:description]).to be_a(String)

      expect(vendor[:data][:attributes]).to have_key(:contact_name)
      expect(vendor[:data][:attributes][:contact_name]).to be_a(String)

      expect(vendor[:data][:attributes]).to have_key(:contact_phone)
      expect(vendor[:data][:attributes][:contact_phone]).to be_a(String)

      expect(vendor[:data][:attributes]).to have_key(:credit_accepted)
      expect(vendor[:data][:attributes][:credit_accepted]).to be_a(TrueClass).or be_a(FalseClass)
    end
  end

  context "sad path - invalid vendor ID" do
    it "returns an erro if ID is not valid" do
      invalid_id = "123123123123"

      get "/api/v0/vendors/#{invalid_id}"

      expect(response).to have_http_status(:not_found)
      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response).to have_key(:errors)
      expect(error_response[:errors].first).to have_key(:detail)
      expect(error_response[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=#{invalid_id}")
    end
  end
end