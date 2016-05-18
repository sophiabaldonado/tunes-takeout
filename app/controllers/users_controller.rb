class UsersController < ApplicationController

  def self.find_or_create_from_omniauth(auth_hash)
    # Find or create a user
    user = User.find_by(uid: auth_hash.uid, provider: auth_hash[:provider])
    if !user.nil?
      return user
    else
      user = User.new(name: auth_hash[:info][:name], uid: auth_hash[:uid], provider: auth_hash[:provider])
      user.save
      if user.save
        return user
      else
        return nil
      end
    end
  end


end
