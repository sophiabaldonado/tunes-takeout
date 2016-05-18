class User < ActiveRecord::Base
  validates :name, :uid, :provider, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    # Find or create a user
    user = self.find_by(uid: auth_hash["info"]["id"], provider: auth_hash[:provider])
    if !user.nil?
      return user
    else
      user = User.new(name: auth_hash["info"]["display_name"], uid: auth_hash["info"]["id"], provider: auth_hash[:provider])

      if user.save
        return user
      else
        return nil
      end
    end
  end

end
