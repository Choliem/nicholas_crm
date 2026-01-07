module Admin
  class UsersController < ApplicationController
    before_action :authorized
    before_action :ensure_admin

    def index
      @users = User.all.order(created_at: :desc)
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admin_users_path, notice: "User #{@user.name} updated successfully."
      else
        redirect_to admin_users_path, alert: "Failed to update user."
      end
    end

    private

    def ensure_admin
      redirect_to root_path, alert: "Access Denied" unless current_user&.role == 'admin'
    end

    def user_params
      params.require(:user).permit(:role, :banned, :ban_reason)
    end
  end
end
