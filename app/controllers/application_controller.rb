class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def login(user)
    session[:user_id] = user.id
  end
  helper_method :login

  def authorize
    render file: 'public/401.html', status: :unauthorized unless current_user.admin
  end
end
