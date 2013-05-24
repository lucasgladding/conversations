class AdminController < ApplicationController
  before_filter :authorize_admin

  private

  def authorize_admin
    unless current_user && current_user.administrator
      redirect_to login_url, notice: 'Please log in as an administrator.'
    end
  end

end
