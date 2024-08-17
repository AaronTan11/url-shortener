class ApplicationController < ActionController::Base
  before_action :set_current_user

  private

  def set_current_user
    return unless session[:user_id]

    @set_current_user ||= User.find(session[:user_id])
  end

  def authenticate_user!
    redirect_to login_path unless set_current_user
  end
end
