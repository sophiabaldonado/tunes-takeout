class TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com/"
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

end
