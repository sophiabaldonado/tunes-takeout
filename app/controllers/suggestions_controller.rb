# require_relative '../../lib/tunestakeoutwrapper'

class SuggestionsController < ApplicationController
  def index
    # @favorites = # TunesTakeoutWrapper.favorites
    @tunes_takeout_suggestions = TunesTakeoutWrapper.search(params["search"]).suggestions
    @suggestions = sort_suggestions(@tunes_takeout_suggestions)

    if @suggestions.nil?
      redirect_to root_path, notice: "No matches for #{params["search"]}!"
    else
      render :index
    end
  end

  def favorites

  end

  def favorite

  end

  def unfavorite

  end

  private
  def search_tunes_params
    params.permit[:search]
  end

end
