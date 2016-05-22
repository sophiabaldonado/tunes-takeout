require 'yelp'

class Food
  attr_reader :name, :link, :phone, :display_address, :cross_streets, :image, :rating

  def initialize(business)
    @name = ["Ohana", "blah", "whoa"].sample
    @link = "http://www.yelp.com/biz/ohana-seattle-2?utm_campaign=yelp_api&utm_medium=api_v2_business&utm_source=edI0YHhkkycExgDVhdgJQg"
    @phone = "+1-206-956-9329"
    @display_address = ["2207 1st Ave", "Belltown", "Seattle, WA 98121"]
    @cross_streets = "Bell St & Blanchard St"
    @image = "https://s3-media1.fl.yelpcdn.com/bphoto/bdP8-Xy2leqilMajcQW7Fw/ms.jpg"
    @rating = {
      :rating=>3.5, :stars=>"https://s3-media1.fl.yelpcdn.com/assets/2/www/img/5ef3eb3cb162/ico/stars/v1/stars_3_half.png"
    }
  end

  # def initialize(business)
  #   @name = business.name
  #   @link = business.url
  #   @phone = business.display_phone
  #   @display_address = business.location.display_address
  #   @cross_streets = business.location.cross_streets
  #   @image = business.image_url
  #   @rating = {
  #     rating: business.rating,
  #     stars: business.rating_img_url
  #   }
  # end

  def self.suggested_food(suggestion)
    self.search(suggestion["food_id"])
  end

  def self.search(food_id)
    # business = Yelp.client.business(food_id.parameterize).business
    business = "fake"
    self.new(business)
  end
end
