class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authorized_manager?
    redirect_to root_path, alert: "Hanya Manager yang boleh akses!" unless current_user&.role == "manager"
  end
end