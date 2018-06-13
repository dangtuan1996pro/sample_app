class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by email: params[:user][:email].downcase
    if user&.authenticate params[:user][:password]
      log_in user
      check_remember params[:user][:remember], user
      redirect_to user
    else
      flash.now[:danger] = t ".flash_danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
