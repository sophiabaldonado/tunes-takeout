# require_relative '../../lib/tunestakeoutwrapper'

class SuggestionsController < ApplicationController
  def index
    $search ||= params["search"]
    # @favorites = # TunesTakeoutWrapper.favorites
    @tunes_takeout_suggestions = TunesTakeoutWrapper.search($search).suggestions
    @suggestions = sort_suggestions(@tunes_takeout_suggestions)

    if @suggestions.nil?
      redirect_to root_path, notice: "No matches for #{params["search"]}!"
    else
      render :index
    end
  end

  def favorites
    user_id = current_user.uid
    @fav_suggestions = TunesTakeoutWrapper.favorites(user_id).suggestions
    @suggestions = sort_suggestions(@fav_suggestions)
    render :index
  end

  def favorite
    @suggestion_id = params[:suggestion_id]
    TunesTakeoutWrapper.favorite(@user_id, @suggestion_id)

    # @tunes_takeout_suggestions = TunesTakeoutWrapper.search($search).suggestions

    # redirect_to suggestions_path
    render :index
  end

  def unfavorite

  end

  private
  def search_tunes_params
    params.permit[:search]
  end

end
