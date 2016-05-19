class SuggestionsController < ApplicationController

  def index
    @top_suggestions_ids = TunesTakeoutWrapper.top_twenty
    @top_suggestions = TunesTakeoutWrapper.find_many(@top_suggestions_ids).suggestions
    @suggestions = sort_suggestions(@top_suggestions)
  end

  def show
    # @favorites = # TunesTakeoutWrapper.favorites
    @tunes_takeout_suggestions = TunesTakeoutWrapper.search(params[:search], params[:limit]).suggestions
    # @tunes_takeout_suggestions = fake_suggestion
    @suggestions = sort_suggestions(@tunes_takeout_suggestions)
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

    @tunes_takeout_suggestions = TunesTakeoutWrapper.search(params[:search], params[:limit]).suggestions
    @suggestions = sort_suggestions(@tunes_takeout_suggestions)

    # redirect_to suggestions_path
    render :show
  end

  def unfavorite

  end

  private
  def search_tunes_params
    params.permit[:search]
  end

end
