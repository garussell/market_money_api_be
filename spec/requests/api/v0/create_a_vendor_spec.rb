require 'rails_helper'

describe "Create A Vendor" do
  context "happy path" do
    before do
      @vendor_attributes = attributes_for(:vendor)
    end

    it "all attributes are present in the response" do   
      post "/api/v0/vendors", params: { vendor: @vendor_attributes }

      expect(response).to have_http_status(:created)
      vendor = JSON.parse(response.body, symbolize_names: true)

      expect(vendor[:data]).to have_key(:id)
      expect(vendor[:data][:id]).to be_an(String)

      expect(vendor[:data]).to have_key(:type)
      expect(vendor[:data][:type]).to eq("vendor")
      
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

  context "sad path" do
    it "returns error when missing attributes" do
      invalid_attributes = { name: "" }

      post "/api/v0/vendors", params: { vendor: invalid_attributes }

      expect(response).to have_http_status(:bad_request)
      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response).to have_key(:errors)
    
      expect(error_response[:errors].first[:detail]).to eq(["Name can't be blank", "Description can't be blank", "Contact name can't be blank", "Contact phone can't be blank", "Credit accepted is not included in the list"])
    end
  end
end