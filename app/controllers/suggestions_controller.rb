class SuggestionsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def index
    choose_correct_suggestions
  end

  def show
    choose_correct_suggestions

    if @suggestions.nil?
      redirect_to root_path, notice: "No matches for #{params["search"]}!"
    else
      render :show
    end
  end

  def favorites
    user_id = current_user.uid
    fav_suggestions_ids = TunesTakeoutWrapper.favorites(user_id) #=> returns array of ids
    fav_suggestions = TunesTakeoutWrapper.find_many(fav_suggestions_ids).suggestions
    @suggestions = transform_suggestions(fav_suggestions)

    render :show
  end

  def favorite
    suggestion_id = params[:suggestion_id]["suggestion_id"]
    user_id = current_user.uid
    TunesTakeoutWrapper.favorite(user_id, suggestion_id)
    choose_correct_suggestions
    render current_page
  end

  def unfavorite
    suggestion_id = params[:suggestion_id]["suggestion_id"]
    user_id = current_user.uid
    TunesTakeoutWrapper.unfavorite(user_id, suggestion_id)
    choose_correct_suggestions
    render current_page
  end

  private
  def search_tunes_params
    params.permit[:search]
  end

  def transform_suggestions(raw_suggestions)
    raw_suggestions.map do |sug|
      {
        id: sug["id"],
        music: Music.suggested_music(sug),
        food: Food.suggested_food(sug)
      }
    end
  end

  def choose_correct_suggestions
    # fake suggestions for styling
    @suggestions = transform_suggestions(fake_suggestions[:suggestions])


    # search, limit = params[:search], params[:limit]
    # if search && search != ""
    #   tunes_takeout_suggestions = TunesTakeoutWrapper.search(search, limit).suggestions
    #   @suggestions = transform_suggestions(tunes_takeout_suggestions)
    # elsif search != "" && current_page != "/"
    #   render :index, notice: "Search cannot be blank"
    # else
    #   top_suggestions_ids = TunesTakeoutWrapper.top_twenty
    #   top_suggestions = TunesTakeoutWrapper.find_many(top_suggestions_ids).suggestions
    #   @suggestions = transform_suggestions(top_suggestions)
    # end
  end

  def fake_suggestions
    single_suggestion = {
      "id" => "VzoikPLQUk2WS7xp",
      "food_id" => "ohana-seattle-2",
      "music_id" => "0BjkSCLEHlcsogSeDim01W",
      "music_type" => "track"
    }

    many_suggestions = {
      "suggestions": [
        single_suggestion,
        single_suggestion,
        single_suggestion
      ]
    }


  end

end
