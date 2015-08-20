class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      log_in_user!
      redirect_to user_url(@user)
    else
      # Flash errors
      render :new
    end
  end

  def new
    @user = User.new
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
