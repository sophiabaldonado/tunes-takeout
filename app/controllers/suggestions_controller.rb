# require_relative '../../lib/tunestakeoutwrapper'

class SuggestionsController < ApplicationController
  def index
    # @favorites = # TunesTakeoutWrapper.favorites
    @tunes_takeout = TunesTakeoutWrapper.search(search_tunes_params["search"])
    @suggestions = @tunes_takeout.suggestions
    if @suggestions.nil?
      redirect_to root_path, notice: "No matches for #{params["search"]}!"
    else
      render :index
    end
    # raise
    # @suggestion = TunesTakeoutWrapper.search(params[:query])
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
