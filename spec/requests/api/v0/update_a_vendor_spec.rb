require 'rails_helper'

describe "Update A Vendor" do
  before do
    @vendor = create(:vendor)
  end

  context "happy path - valid entry" do
    it "updates the vendor successfully" do
      get "/api/v0/vendors/#{@vendor.id}"

      exhisting_record = JSON.parse(response.body, symbolize_names: true)

      expect(exhisting_record[:data][:attributes][:name]).to eq(@vendor.name)
      expect(exhisting_record[:data][:attributes][:description]).to eq(@vendor.description)

      # Update Record
      new_attributes = { name: "Patch Adams", description: "To the windows, to the wall." }

      patch "/api/v0/vendors/#{@vendor.id}", params: { vendor: new_attributes }

      expect(response).to have_http_status(:ok)
      vendor = JSON.parse(response.body, symbolize_names: true)

      expect(vendor[:data][:attributes][:name]).to eq("Patch Adams")
      expect(vendor[:data][:attributes][:description]).to eq("To the windows, to the wall.")
    end
  end

  context "sad paths" do
    it "returns error if vender ID does not exhist" do
      invalid_id = "123123123123" 
      
      patch "/api/v0/vendors/#{invalid_id}", params: { vendor: { name: "Carrot Top" } }
      
      expect(response).to have_http_status(:not_found)
    end

    it "returns error if attributes are missing" do
      invalid_attributes = { name: "" }
  
      patch "/api/v0/vendors/#{@vendor.id}", params: { vendor: invalid_attributes }
  
      expect(response).to have_http_status(:unprocessable_entity)
      error_response = JSON.parse(response.body, symbolize_names: true)
  
      expect(error_response).to have_key(:errors)
      expect(error_response[:errors].first).to have_key(:detail)
      expect(error_response[:errors].first[:detail]).to eq(["Name can't be blank"])
    end
  end
end