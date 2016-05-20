class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper_method :current_user, :user_favorited?

  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_page
    request.env['PATH_INFO']
  end

  def user_favorited?(suggestion_id)
    users_favorites = TunesTakeoutWrapper.favorites(current_user.uid)
    users_favorites.include? suggestion_id
  end

  def temp #skip before action for login

  end

end
