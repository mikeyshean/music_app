class SessionsController < ApplicationController

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    render :new if user.nil?

    log_in_user!(user)
    redirect_to user_url(user)
  end

  def new
    @user = User.new
  end

  def destroy
    log_out_user!
    redirect_to new_session_url
  end

end
