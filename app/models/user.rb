class User < ActiveRecord::Base
  validates :name, :uid, :provider, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    # Find or create a user
    user = if auth_hash["uid"]
      self.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])
    else
      self.find_by(uid: auth_hash["info"]["id"], provider: auth_hash["provider"])
    end
    
    if user.nil?
      user = User.new
      user.name = auth_hash["info"]["display_name"]
      user.uid = auth_hash["uid"] || auth_hash["info"]["id"]
      user.provider = auth_hash["provider"]
      default_photo = 'https://cdn0.iconfinder.com/data/icons/human-resources-and-strategy/80/Human_resource_strategy-01-512.png'
      auth_hash["info"]["images"].empty? ? user.photo_url = default_photo : user.photo_url = auth_hash["info"]["images"][0]["url"]

      user.save ? user : nil
    else
      user
    end
  end

end
