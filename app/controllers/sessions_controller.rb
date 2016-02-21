class SessionsController < ApplicationController
  before_action :restrict_user, only: [:new, :create]

  def new

  end

  def create
    # render 'new'
    user = User.find_by_username(params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in !"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Wrong username or password"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out!"
    redirect_to root_path
  end
end