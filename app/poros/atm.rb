class Atm
  attr_reader :id,
              :type,
              :name,
              :address,
              :lat,
              :lon,
              :distance

  def initialize(search_results)
    @id = nil
    @type = 'atm'
    @name = search_results[:results][0][:poi][:name]
    @address = search_results[:results][0][:address][:freeformAddress]
    @lat = search_results[:results][0][:position][:lat]
    @lon = search_results[:results][0][:position][:lon]
    @distance = search_results[:results][0][:dist]
  end
end

