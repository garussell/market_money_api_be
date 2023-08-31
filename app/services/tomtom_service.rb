class TomtomService
  def self.search_nearby_atms(lat, lon)
    get_url(lat: lat, lon: lon)
  end
  
  def self.get_url(params)
    response = conn.get("search/2/categorySearch/ATM.json", params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "https://api.tomtom.com/") do |f|
      f.params["key"] = Rails.application.credentials.tomtom[:key]
    end
  end
end
