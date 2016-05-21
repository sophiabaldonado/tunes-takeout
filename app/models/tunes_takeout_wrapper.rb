require 'json'

class TunesTakeoutWrapper
  # validate :search, presence: true, only: [:show]

  BASE_URL = "https://tunes-takeout-api.herokuapp.com"
  attr_reader :suggestions, :href

  def initialize(data)
    return if data.nil?

    @suggestions = data["suggestions"]
    @href = data["href"]
  end

  def self.search(query, limit=10, seed=nil)
    data = if limit
      HTTParty.get(BASE_URL + "/v1/suggestions/search?query=#{query}&limit=#{limit}").parsed_response
    else
      HTTParty.get(BASE_URL + "/v1/suggestions/search?query=#{query}").parsed_response
    end

    self.new(data)
  end

  def self.find_many(ids_array)
    data = {
      "suggestions" => ids_array.map { |id|
        HTTParty.get(BASE_URL + "/v1/suggestions/#{id}").parsed_response["suggestion"]
      }
    }

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

  private
  # def validate
  #   if params[:search]
  #     errors.add(:search, "can't be blank") if params[:search].blank?
  #     # any other validations
  #   end
  # end
  #
end
