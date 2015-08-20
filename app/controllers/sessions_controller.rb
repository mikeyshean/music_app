class SessionsController < ApplicationController

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if user.nil?
      flash.now[:errors] = ["Invalid login credentials!"]
      render :new
    elsif !user.activated?
      flash.now[:errors] = ["Please activate your account!"]
      render :new
    else
      log_in_user!(user)
      redirect_to user_url(user)
    end
  end

  def new
    @user = User.new
  end

  def destroy
    log_out_user!
    redirect_to new_session_url
  end

end
