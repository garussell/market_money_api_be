require 'rails_helper'

RSpec.describe Vendor, type: :model do
  before do
    @vendors = create_list(:vendor, 10)
    @markets = create_list(:market, 10)
    @market_vendors = []
      
    10.times do |i|
      @market_vendors << create(:market_vendor, market: @markets[i], vendor: @vendors[i])
    end
  end

  describe "relationships" do
    it { should have_many(:market_vendors) }
    it { should have_many(:markets).through(:market_vendors) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :contact_name }
    it { should validate_presence_of :contact_phone }
    it { should allow_value(true).for(:credit_accepted) }
    it { should allow_value(false).for(:credit_accepted) }
    it { should_not allow_value(nil).for(:credit_accepted) }
  end

  describe "states_sold_in" do
    it "returns an array of states vendor sells in" do
      expect(@vendors.first.states_sold_in).to be_an(Array)
    end
  end
end