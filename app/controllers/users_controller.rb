class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(required_user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to short_urls_path, notice: 'Account created successfully!'
    else
      render :new
    end
  end

  private

  def required_user_params
    params.require(:user).permit(:username, :password)
  end
end
