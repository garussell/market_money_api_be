require 'rails_helper'

RSpec.describe MarketVendor, type: :model do
  describe "relationships" do
    it { should belong_to :market }
    it { should belong_to :vendor }
  end

  describe "validations" do
    it { should validate_presence_of :market_id }
    it { should validate_presence_of :vendor_id }
  end

  # describe "market_vendor_association" do
  #   it "returns an error if the association exists" do
  #     market_vendor_1 = create(:market_vendor)

  #   end
  # end
end