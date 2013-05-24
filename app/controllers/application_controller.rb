class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authorize

  helper_method :current_user, :logged_in?

  protected

  def authorize
    unless current_user
      redirect_to login_url, notice: 'Please log in.'
    end
  end

  def authorize_admin
    unless current_user && current_user.administrator
      redirect_to login_url, notice: 'Please log in as an administrator.'
    end
  end

  def current_user
    @current_user = User.find_by_auth_token(cookies[:auth_token])
  end

  def logged_in?
    current_user != nil
  end

end
