class LoginController < ApplicationController
  skip_before_filter :authorize

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      cookies.permanent[:auth_token] = user.auth_token
      redirect_to root_url, notice: 'You have been logged in.'
    else
      flash.now[:alert] = 'Your username or password was incorrect.'
      render 'new'
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to login_url, notice: 'You have been logged out.'
  end

end
