skip_before_action :authenticate_user!, only: [:new, :create]
class SessionsController < ApplicationController
  # Lewati pengecekan login hanya untuk halaman login itu sendiri
  # (Kita akan buat filter login nanti)

  def new
    # Hanya menampilkan view login
  end

  def create
    user = User.find_by(email: params[:email])
    
    # .authenticate disediakan oleh has_secure_password & bcrypt
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      session[:user_role] = user.role # Kita simpan role-nya (manager/sales)
      redirect_to root_path, notice: "Selamat datang kembali, #{user.name}!"
    else
      flash.now[:alert] = "Email atau password salah."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_role] = nil
    redirect_to login_path, notice: "Anda telah keluar dari sistem."
  end
end