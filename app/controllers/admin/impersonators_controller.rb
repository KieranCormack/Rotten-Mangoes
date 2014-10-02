class Admin::ImpersonatorsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    if current_user.try(:admin)  
      session[:admin] = current_user.id
      session[:user_id] = user.id
      redirect_to movies_path
    end
  end

end
