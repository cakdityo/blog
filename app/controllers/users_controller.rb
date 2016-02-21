class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :author?, only: [:edit, :update]
  before_action :restrict_user, only: [:new, :create]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.username} !"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account was successfully updated!"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def author?
    if current_user != @user
      flash[:danger] = "Sorry, you don't have privilege to do that"
      redirect_to articles_path
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
