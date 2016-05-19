class SuggestionsController < ApplicationController

  def index
    choose_correct_suggestions
  end

  def show
    # @favorites = # TunesTakeoutWrapper.favorites
    # @tunes_takeout_suggestions = fake_suggestion
    choose_correct_suggestions
    if @suggestions.nil?
      redirect_to root_path, notice: "No matches for #{params["search"]}!"
    else
      render :show
    end
  end

  def favorites
    user_id = current_user.uid
    @fav_suggestions_ids = TunesTakeoutWrapper.favorites(user_id) #=> returns array of ids
    @fav_suggestions = TunesTakeoutWrapper.find_many(@fav_suggestions_ids).suggestions
    @suggestions = sort_suggestions(@fav_suggestions)

    render :show
  end

  def favorite
    @suggestion_id = params[:suggestion_id]["suggestion_id"]
    @user_id = current_user.uid
    TunesTakeoutWrapper.favorite(@user_id, @suggestion_id)
    choose_correct_suggestions
    render current_page
  end

  def unfavorite
    @suggestion_id = params[:suggestion_id]["suggestion_id"]
    @user_id = current_user.uid
    TunesTakeoutWrapper.unfavorite(@user_id, @suggestion_id)
    choose_correct_suggestions
    render current_page
  end

  private
  def search_tunes_params
    params.permit[:search]
  end

end
