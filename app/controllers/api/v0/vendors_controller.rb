class Api::V0::VendorsController < ApplicationController
  def index
    begin
      market = Market.find(params[:market_id])
      vendors = market.vendors
      render json: VendorSerializer.new(vendors)
    rescue
      render json: { errors: [{ detail: "Couldn't find Market with 'id'=#{params[:market_id]}"}]}, status: :not_found
    end
  end

  def show
    begin
      render json: VendorSerializer.new(Vendor.find(params[:id]))
    rescue
      render json: { errors: [{ detail:"Couldn't find Vendor with 'id'=#{params[:id]}"}]}, status: :not_found
    end
  end
end