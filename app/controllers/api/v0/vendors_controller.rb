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
end