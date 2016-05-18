class HomeController < ApplicationController
  def index
    @user = current_user
    @suggestion = TunesTakeoutWrapper.new
    raise
  end
end
