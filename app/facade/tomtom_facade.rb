class TomtomFacade
  def self.parse_atms(search_results)
    results = search_results[:results].map do |result|
        {
        id: nil,
        type: 'atm',
        attributes: {
          name: result[:poi][:name],
          address: result[:address][:freeformAddress],
          lat: result[:position][:lat],
          lon: result[:position][:lon],
          distance: result[:dist] 
          }
        }
    end

    sorted_results = sort_by_distance(results)
    sorted_results
  end 

  private

  def self.sort_by_distance(results)
    results.sort_by { |atm| atm[:attributes][:distance] }
  end
end

