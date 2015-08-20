class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = ["Check your e-mail to activate!"]
      send_activation_email(@user)
      redirect_to new_session_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def activate
    @user = User.find_by_activation_token(params[:activation_token])
    if @user.nil?
      flash[:notice] = ["Invalid Activation Token"]
      redirect_to new_user_url
    else
      @user.toggle(:activated)
      @user.activation_token = nil
      @user.save!
      redirect_to user_url(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
