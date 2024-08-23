# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create]

  def new; end

  def create
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to short_urls_path
    else
      flash.now[:error] = 'Invalid username or password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'You are logged out!'
  end

  private

  def redirect_if_logged_in
    redirect_to short_urls_path if current_user
  end
end
