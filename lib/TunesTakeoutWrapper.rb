require 'httparty'

class TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com/"
  attr_reader

  # def initialize(data)
  #   @name = data["name"]
  #   @moves = data["moves"]
  #   @sprites = reject_null_sprites(data["sprites"])
  # end
  #
  # def sprite_urls
  #   sprites.values
  # end
  #
  # def favorite_move
  #   HTTParty.get(moves.sample["move"]["url"]).parsed_response
  # end
  #
  # def self.find(id)
  #   # http://pokeapi.co/api/v2/pokemon/25/
  #   # find a pokemon with id
  #   data = HTTParty.get(BASE_URL + "pokemon/#{id}/").parsed_response
  #
  #   # return an instance of pokemon for that id
  #   self.new(data)
  # end
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
