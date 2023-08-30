class MarketSearchService
  def self.search(search_params)
    if valid_params?(search_params)
      markets = Market.where(search_params)
      [markets, :ok]  
    else
      [{ errors: [{ detail: "Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint." }] }, :unprocessable_entity]  
    end
  end
  

  private

  def self.valid_params?(search_params)
    valid_combinations = [
      [:name],
      [:state],
      [:state, :name],
      [:city, :state],
      [:city, :state, :name]
    ]

    search_keys = search_params.keys.map(&:to_sym)
    valid_combinations.include?(search_keys)
  end
end