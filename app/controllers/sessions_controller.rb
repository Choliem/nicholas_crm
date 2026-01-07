class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path, notice: "Berhasil login!"
    else
      flash.now[:alert] = "Username atau password salah"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Berhasil logout!"
  end
end