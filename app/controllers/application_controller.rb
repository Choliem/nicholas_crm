class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def authorized
    redirect_to login_path, alert: "Silakan login terlebih dahulu" unless logged_in?
    
    if logged_in? && current_user.banned?
      reason = current_user.ban_reason
      session[:user_id] = nil
      redirect_to login_path, alert: "Akun Anda telah dibekukan: #{reason}"
    end
  end
end