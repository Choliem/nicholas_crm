class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create], raise: false

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    @user.role = "staff" if @user.role.blank?

    if @user.save
      session[:user_id] = @user.id 
      
      redirect_to root_path, notice: "Akun #{@user.name} berhasil dibuat! Selamat bekerja di PT. SMART."
    else
      flash.now[:alert] = "Pendaftaran gagal: " + @user.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :role)
  end
end