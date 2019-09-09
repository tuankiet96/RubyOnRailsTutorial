class SessionsController < ApplicationController
  before_action :require_login, only: [:new, :create]
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash.now[:success] = "Wellcome to my App"
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash.now[:success] = "You are logged out"
    redirect_to login_path
  end

  private 
  def require_login
    if logged_in?
      redirect_to root_path
    end
  end
end
