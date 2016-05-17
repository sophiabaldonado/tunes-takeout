class HomeController < ApplicationController
  def index
    @suggestion = TunesTakeoutWrapper.new
  end
end
