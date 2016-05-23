require 'test_helper'

class MusicTest < ActiveSupport::TestCase

  describe Music do
    before do
      @suggestions = TunesTakeoutWrapper.find_many(["V0FRQlElJwADzFmP", "Vz0KO4-RRwADbn8x"])
      @top_twenty = TunesTakeoutWrapper.top_twenty
      @search = TunesTakeoutWrapper.search("hell")
    end



  end

end
