class DashboardController < ApplicationController
  before_action :authorized

  def index
    # Total Revenue (Approved Projects)
    @total_revenue = Project.where(status: 'Approved').joins(:product).sum('products.price')
    @pencapaian_sekarang = @total_revenue / 1_000_000 # Dalam Juta

    today = Time.current
    target_record = SalesTarget.find_by(month: today.month, year: today.year)
    @target_penjualan = target_record ? target_record.amount : 100 # Default 100 Juta if not set

    @persentase = @target_penjualan > 0 ? (@pencapaian_sekarang.to_f / @target_penjualan * 100).round : 0

    @layanan_aktif = Project.where(status: 'Approved').count
    @layanan_pending = Project.where(status: 'Pending Approval').count
    
    # Recent Activities
    @recent_leads = Lead.order(created_at: :desc).limit(5)
    @recent_projects = Project.order(created_at: :desc).limit(5)
  end
end