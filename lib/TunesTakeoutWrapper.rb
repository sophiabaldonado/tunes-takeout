class TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com/"
  attr_reader :suggestions, :href

  def initialize(data)
    @suggestions = data["suggestions"]
    @href = data["href"]
  end
  #
  # def sprite_urls
  #   sprites.values
  # end
  #
  # def favorite_move
  #   HTTParty.get(moves.sample["move"]["url"]).parsed_response
  # end
  #
  def self.search(query, limit=10, seed=nil)
    # http://pokeapi.co/api/v2/pokemon/25/
    # searcj tunes-takeout-api
    data = HTTParty.get(BASE_URL + "/v1/suggestions/search?query=#{query}").parsed_response

    # return an instance of pokemon for that id
    self.new(data)
  end
  #
  # private
  #
  # def reject_null_sprites(sprite_hash)
  #   sprite_hash.reject do |name, url|
  #     url.nil?
  #   end
  # end
  #

end
