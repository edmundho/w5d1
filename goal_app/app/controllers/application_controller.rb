class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in

  def login(user)
    session[:session_token] = user.reset_token
    @current_user = user
  end

  def logged_in
    !!current_user
  end

  def current_user
    return nil if session[:session_token].nil?
    @current_user || User.find_by(session_token: session[:session_token])
  end
end
