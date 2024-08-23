# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_current_user
  helper_method :current_user

  private

  def set_current_user
    return unless session[:user_id]

    @set_current_user ||= User.find(session[:user_id])
  end

  def authenticate_user!
    redirect_to login_path unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
