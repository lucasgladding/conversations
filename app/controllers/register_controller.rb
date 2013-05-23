class RegisterController < ApplicationController
  skip_before_filter :authorize

  def new
    @user = User.new
  end

  def create
    @user = User.new(register_params)
    if @user.save
      cookies.permanent[:auth_token] = @user.auth_token
      redirect_to root_url, notice: 'You have been registered.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  private

  def register_params
    params.require(:user).permit(:username, :email, :password, :password_digest)
  end

end
