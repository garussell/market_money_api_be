require 'rails_helper'

RSpec.describe Market, type: :model do
  before do
    vendors = create_list(:vendor, 10)
    co_markets = create_list(:market, 10, state: 'Colorado')
    ca_markets = create_list(:market, 10, state: 'California')
    az_markets = create_list(:market, 10, state: 'Arizona')

    market_vendors = []
    10.times do |i|
      market_vendors << create(:market_vendor, market: co_markets[i], vendor: vendors[i])
    end
    10.times do |i|
      market_vendors << create(:market_vendor, market: ca_markets[i], vendor: vendors[i])
    end
    10.times do |i|
      market_vendors << create(:market_vendor, market: az_markets[i], vendor: vendors[i])
    end
  end

  describe "relationships" do
    it { should have_many(:market_vendors) }
    it { should have_many(:vendors).through(:market_vendors) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street }
    it { should validate_presence_of :city }
    it { should validate_presence_of :county }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :lat }
    it { should validate_presence_of :lon }
    it { should validate_presence_of :vendor_count }
  end

  describe "popular_states" do
    it "can get a list of popular states and vendor count" do
      expect(Market.vendors_per_state.length).to eq(3)
    end
  end
end