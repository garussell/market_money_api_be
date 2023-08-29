class Api::V0::MarketsController < ApplicationController
  def index
    render json: MarketSerializer.new(Market.all)
  end
  
  def show
    begin
      market = Market.find(params[:id])
      render json: MarketSerializer.new(market)
    rescue ActiveRecord::RecordNotFound
      render json: { errors: [{ detail: "Couldn't find Market with 'id'=#{params[:id]}"}]}, status: :not_found
    end
  end
end