class Admin::ImpersonatorsController < ApplicationController

  def create
    @user = User.find_by(id: params[:user_id])
    if impersonating?
      session[:user_id] =  session[:admin]
      session[:admin] = nil
      redirect_to admin_users_path
    elsif current_user.try(:admin)  
      session[:admin] = current_user.id
      session[:user_id] = @user.id
      redirect_to movies_path
    end
  end

end
