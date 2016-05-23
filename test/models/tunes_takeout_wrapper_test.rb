require 'test_helper'
require 'tunes_takeout_wrapper'

class TunesTakeoutWrapperTest < ActiveSupport::TestCase

  describe TunesTakeoutWrapper do
    it "uses the correct api url" do
      assert_equal "https://tunes-takeout-api.herokuapp.com", TunesTakeoutWrapper::BASE_URL
    end

    describe "Tunes Takeout API", :vcr do
      before do
        @suggestions = TunesTakeoutWrapper.find_many(["V0FRQlElJwADzFmP", "Vz0KO4-RRwADbn8x"])
        @top_twenty = TunesTakeoutWrapper.top_twenty
        @search = TunesTakeoutWrapper.search("mushroom")
        @search_1 = TunesTakeoutWrapper.search("mushroom", 1)
      end

      it "returns an object with suggestions if given suggestion_ids", :vcr do
        assert_kind_of TunesTakeoutWrapper, @suggestions
        refute_nil @suggestions.suggestions
      end

      it "can retrieve top 20 suggestions", :vcr do
        assert_equal 20, @top_twenty.length
      end

      it "returns a specified numbers of suggestions when given a limit" , :vcr do
        assert_equal @search_1.suggestions.count, 1
      end

      it "returns 10 suggestions by default", :vcr do
        @search = TunesTakeoutWrapper.search("mushroom")
        assert_equal @search.suggestions.length, 10
      end

      it "returns suggestions that contain suggestion_ids", :vcr do
        refute_nil @suggestions.suggestions.last["id"]
      end

      it "returns suggestions that contain food_ids", :vcr do
        refute_nil @suggestions.suggestions.last["food_id"]
      end

      it "returns suggestions that contain music ids", :vcr do
        refute_nil @suggestions.suggestions.last["music_id"]
      end

      it "returns suggestions that contain music types", :vcr do
        refute_nil @suggestions.suggestions.last["music_type"]
      end

      it "can favorite a suggestion for a user", :vcr do
        fav_response = TunesTakeoutWrapper.favorite("known_user", "V0FRQlElJwADzFmP").response.code
        favorites = TunesTakeoutWrapper.favorites("known_user")

        assert_equal "201", fav_response
        assert true, favorites.include?("V0FRQlElJwADzFmP")
      end

      it "can unfavorite a suggestion for a user", :vcr do
        fav_response = TunesTakeoutWrapper.favorite("known_user", "Vz0LQQjNqAADBbTP").response.code
        unfav_response = TunesTakeoutWrapper.unfavorite("known_user", "Vz0LQQjNqAADBbTP").response.code
        favorites = TunesTakeoutWrapper.favorites("known_user")

        assert_equal "201", fav_response
        assert_equal "204", unfav_response
        refute favorites.include?("Vz0LQQjNqAADBbTP")
      end

    end
  end
end
