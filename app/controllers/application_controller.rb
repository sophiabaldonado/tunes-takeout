class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper_method :current_user

  protect_from_forgery with: :exception

  def current_user
    @user ||= User.find_by(id: session[:user_id])
  end

  def sort_suggestions(raw_suggestions)
    raw_suggestions.map do |sug|
      {
        id: sug["id"],
        music: Music.suggested_music(sug),
        food: Food.suggested_food(sug)
      }
    end
  end

  # def fake_suggestion
  # {
  #   "href":"https://tunes-takeout-api.herokapp.com/v1/suggestions/VzoikPLQUk2WS7xp",
  #   "suggestion":{
  #     "id":"VzoikPLQUk2WS7xp",
  #     "food_id":"ohana-seattle-2",
  #     "music_id":"0BjkSCLEHlcsogSeDim01W",
  #     "music_type":"track"
  #   }
  # }
  # end

end
