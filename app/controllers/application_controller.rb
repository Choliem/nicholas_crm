class ApplicationController < ActionController::Base
  # Membuat method ini bisa diakses di View (HTML)
  helper_method :current_user, :logged_in?

  def current_user
    # Mencari user berdasarkan session[:user_id] jika ada
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # Mengembalikan true jika current_user tidak nil
    current_user.present?
  end

  def authorized
    # Redirect ke login jika mencoba akses halaman internal tanpa login
    redirect_to login_path, alert: "Silakan login terlebih dahulu" unless logged_in?
    
    # Force Logout if banned
    if logged_in? && current_user.banned?
      session[:user_id] = nil
      redirect_to login_path, alert: "Akun Anda telah dibekukan: #{current_user.ban_reason}"
    end
  end
end