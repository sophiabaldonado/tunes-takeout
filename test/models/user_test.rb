require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @known = {
      "provider" => 'spotify',
      "info" => { "id" => "known_user", "display_name" => "known user",
        "images" => ["url" => "http://images.clipartpanda.com/cute-dinosaur-9f906fb381d0224fcba70da266293035.png"]
       }
    }
    @unknown = {
      "provider" => 'spotify',
      "info" => { "id" => "unknown_user", "display_name" => "unknown user",
        "images" => ["url" => "http://images.clipartpanda.com/cute-dinosaur-9f906fb381d0224fcba70da266293035.png"]
      }
    }
    @unknown_with_uid = {
      "provider" => 'spotify',
      "uid" => "top_id",
      "info" => { "id" => "unknown_user", "display_name" => "unknown user",
        "images" => []
      }
    }
  end

  test "can find an existing user given an oauth spotify hash" do
    assert_equal users(:known_user), User.find_or_create_from_omniauth(@known)
  end

  test "can make a new user given the oauth spotify hash of an unknown user" do
    assert_difference 'User.count', 1 do
      @user = User.find_or_create_from_omniauth @unknown
    end
  end

  test "uses oauth data to set user name, provider and uid for new users" do
    user = User.find_or_create_from_omniauth @unknown

    assert_equal @unknown['info']['display_name'], user.name
    assert_equal @unknown['provider'], user.provider
    assert_equal @unknown['info']['id'], user.uid
  end

  test "prefers a top-level uid over a nested id when creating an oauth user" do
    user = User.find_or_create_from_omniauth @unknown_with_uid
    assert_equal @unknown_with_uid['uid'], user.uid
  end
end
