class SalesTargetsController < ApplicationController
  before_action :authorized
  before_action :ensure_manager_or_admin

  def new
    @sales_target = SalesTarget.find_by(month: Time.current.month, year: Time.current.year) || SalesTarget.new
  end

  def create
    @sales_target = SalesTarget.find_or_initialize_by(month: Time.current.month, year: Time.current.year)
    @sales_target.amount = sales_target_params[:amount]

    if @sales_target.save
      redirect_to dashboard_path, notice: "Target Penjualan bulan ini berhasil diperbarui!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def sales_target_params
    params.require(:sales_target).permit(:amount)
  end

  def ensure_manager_or_admin
    redirect_to dashboard_path, alert: "Tidak diizinkan" unless current_user.role.in?(['admin', 'manager'])
  end
end
