class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def restrict_access
    if !current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin?
    @admin ||= @current_user.admin == true if @current_user
  end

  def impersonating?
    actual_user.present?
  end

  def actual_user
    @actual_user ||= User.find(session[:admin]) if session[:admin]
  end

  helper_method :current_user
  helper_method :admin?
  helper_method :impersonating?
  helper_method :actual_user

end
