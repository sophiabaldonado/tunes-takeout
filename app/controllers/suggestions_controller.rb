require_relative '../../lib/tunestakeoutwrapper'

class SuggestionsController < ApplicationController
  def index
    # @favorites = # TunesTakeoutWrapper.favorites
    @tunes_takeout = ::TunesTakeoutWrapper.search("avodaco")
    @suggestions = @tunes_takeout.suggestions
    # raise
    # @suggestion = TunesTakeoutWrapper.search(params[:query])
  end

  def favorites

  end

  def favorite

  end

  def unfavorite

  end

end
