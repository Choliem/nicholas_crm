class ApplicationController < ActionController::Base
  # Jalankan pengecekan login di SETIAP controller secara default
  before_action :authenticate_user!
  
  # Memasukkan fungsi ini agar bisa dipakai di View (HTML)
  helper_method :current_user, :logged_in?

  def current_user
    # Mencari user berdasarkan session ID yang tersimpan saat login
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  private

  def authenticate_user!
    unless logged_in?
      redirect_to login_path, alert: "Akses ditolak! Silakan login terlebih dahulu."
    end
  end
end