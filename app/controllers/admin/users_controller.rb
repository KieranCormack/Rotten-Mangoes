class Admin::UsersController < ApplicationController
  # before_action only: [:index, :edit, :update, :delete]


  def index
    @users = User.order("firstname").page(params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to admin_users_path, notice: "Welcome aboard, #{@user.firstname}!"
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User Deleted."
    redirect_to admin_users_path
  end
  

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end
