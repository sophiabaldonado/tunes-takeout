require 'test_helper'
require 'tunes_takeout_wrapper'

class FoodTest < ActiveSupport::TestCase

  describe Food do
    before do
      @suggestion = TunesTakeoutWrapper.search("mushroom", 1).suggestions.first
      @food_id = "ohana-seattle-2"
      @business = Food.search(@food_id)
      @suggested_business = Food.suggested_food(@suggestion["food_id"])
    end

    it "returns a food object when searched", :vcr do
      assert_kind_of Food, @business
    end

    it "returns a food object from a suggestion_id", :vcr do
      assert_kind_of Food, @suggested_business
    end


  end

end
