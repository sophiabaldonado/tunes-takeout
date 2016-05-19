class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper_method :current_user, :user_favorited?

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

  def user_favorited?(suggestion_id)
    @favorites = TunesTakeoutWrapper.favorites(current_user.uid)
    @favorites.include? suggestion_id
  end

  def choose_correct_suggestions
    if params[:search]
      @tunes_takeout_suggestions = TunesTakeoutWrapper.search(params[:search], params[:limit]).suggestions
      @suggestions = sort_suggestions(@tunes_takeout_suggestions)
    else
      @top_suggestions_ids = TunesTakeoutWrapper.top_twenty
      @top_suggestions = TunesTakeoutWrapper.find_many(@top_suggestions_ids).suggestions
      @suggestions = sort_suggestions(@top_suggestions)
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
