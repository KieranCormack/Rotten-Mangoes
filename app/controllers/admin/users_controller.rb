class Admin::UsersController < ApplicationController
  def index
    @users = User.order("firstname").page(params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end

end
