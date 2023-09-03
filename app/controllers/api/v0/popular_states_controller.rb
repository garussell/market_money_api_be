class Api::V0::PopularStatesController < ApplicationController
  def index
    result = Market.vendors_per_state
    formatted_data = MarketSerializer.popular_states_data(result)
    render json: { data: formatted_data } 
  end
end