class Api::V0::MarketVendorsController < ApplicationController
  def index
    render json: MarketVendorSerializer.new(MarketVendor.all)
  end

  def create
    market_vendor = MarketVendor.new(market_vendor_params)
  
    if MarketVendor.exists?(market_id: market_vendor.market_id, vendor_id: market_vendor.vendor_id)
      render json: { errors: [{ detail: "Market vendor association between market with market_id=#{market_vendor.market_id} and vendor with vendor_id=#{market_vendor.vendor_id} already exists" }] }, status: :unprocessable_entity
    elsif market_vendor.save
      render json: MarketVendorSerializer.new(market_vendor), status: :created
    else
      render json: { errors: [{ detail: market_vendor.errors.full_messages }] }, status: :not_found
    end
  end
  
  
  private

  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end
end