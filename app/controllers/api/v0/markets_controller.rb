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

  def search
    results, status = MarketSearchService.search(search_params)

    if status == :ok
      render json: { data: results, status: status }
    else
      render json: results, status: status
    end
  end

  def nearest_atms
    begin
      market = Market.find(params[:id])
      search_results = TomtomService.search_nearby_atms(market.lat, market.lon)
      formatted_data = TomtomFacade.parse_atms(search_results)
      render json: { data: formatted_data }
    rescue ActiveRecord::RecordNotFound
      render json: { errors: [{ detail: "Couldn't find Market with 'id'=#{params[:id]}"}]}, status: :not_found
    end
  end

  private

  def search_params
    params.permit(:city, :state, :name)
  end
end