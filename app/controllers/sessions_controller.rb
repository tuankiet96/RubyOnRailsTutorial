class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash.now[:success] = "Wellcome to my App"
      log_in user
      redirect_to user
    else
      flash.now[:danger] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    log_out
    flash.now[:success] = "You are logged out"
    redirect_to login_path
  end

end
