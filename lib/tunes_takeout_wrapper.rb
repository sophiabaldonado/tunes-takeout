class TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com"
  attr_reader :suggestions, :href

  def initialize(data=nil)
    @suggestions = data["suggestions"] if data
    @href = data["href"] if data
  end

  def self.search(query, limit=10, seed=nil)
    data = HTTParty.get(BASE_URL + "/v1/suggestions/search?query=#{query}").parsed_response

    # return an instance of pokemon for that id
    self.new(data)
  end

  def self.favorites(user_id)
    data = HTTParty.get(BASE_URL + "/v1/users/#{user_id}/favorites").parsed_response
    self.new(data)
  end

  def self.favorite(user_id, suggestion_id)
    HTTParty.post(BASE_URL + "/v1/users/#{user_id}/favorites", { "suggestion": suggestion_id }.to_json)
  end

  def unfavorite(suggestion)
  end

end
