class Food
  attr_reader :name, :link, :phone, :address, :image, :rating

  def initialize(business)
    @name = business.name
    @link = business.url
    @phone = business.display_phone
    @address = business.location
    @image = business.image_url
    @rating = {
      rating: business.rating,
      stars: business.rating_img_url
    }
  end

  def self.suggested_food(suggestion)
    self.search(suggestion["food_id"])
  end

  def self.search(food_id)
    business = Yelp.client.business(food_id.parameterize).business
    self.new(business)
  end
end
