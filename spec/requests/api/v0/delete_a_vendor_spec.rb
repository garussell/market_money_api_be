require 'rails_helper'

describe "Delete A Vendor" do
  before do
    @vendor = create_list(:vendor, 10)
    @vendor_id = @vendor.first.id
  end

  context "happy path - successful destroy" do
    it "successfully destroys a vendor" do
      delete "/api/v0/vendors/#{@vendor_id}"

      expect(response).to have_http_status(:no_content)
      expect(Vendor.exists?(@vendor_id)).to be false
    end
  end

  context "sad path - vendor does not exhist" do
    it "will return an error if vendor ID is not found" do
      invalid_id = "123123123123" 

      expect {
        delete "/api/v0/vendors/#{invalid_id}"
      }.to raise_error("Couldn't find Vendor with 'id'=#{invalid_id}")
    end
  end
end