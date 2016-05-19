require 'json'

class TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com"
  attr_reader :suggestions, :href

  def initialize(data=nil)
    @suggestions = data["suggestions"] if data
    @href = data["href"] if data
  end

  def self.search(query, limit=10, seed=nil)
    if limit
      data = HTTParty.get(BASE_URL + "/v1/suggestions/search?query=#{query}&limit=#{limit}").parsed_response
    else
      data = HTTParty.get(BASE_URL + "/v1/suggestions/search?query=#{query}").parsed_response
    end

    # return an instance of pokemon for that id
    self.new(data)
  end

  def self.find_many(ids_array)
    data = ids_array.map do |id|
      HTTParty.get(BASE_URL + "/v1/suggestions/#{id}").parsed_response["suggestion"]
    end
    data = { "suggestions" => data }
    self.new(data)
  end

  def self.top_twenty
    data = HTTParty.get(BASE_URL + "/v1/suggestions/top").parsed_response
    data["suggestions"]
    #=> returns array
  end

  def self.favorites(user_id)
    data = HTTParty.get(BASE_URL + "/v1/users/#{user_id}/favorites").parsed_response
    data["suggestions"]
    #=> returns array
  end

  def self.favorite(user_id, suggestion_id)
    HTTParty.post(BASE_URL + "/v1/users/#{user_id}/favorites", { body: { "suggestion": suggestion_id }.to_json} )
  end

  def self.unfavorite(user_id, suggestion_id)
    HTTParty.delete(BASE_URL + "/v1/users/#{user_id}/favorites", { body: { "suggestion": suggestion_id }.to_json} )
  end

end
