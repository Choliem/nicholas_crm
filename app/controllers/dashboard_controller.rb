class DashboardController < ApplicationController
  before_action :authorized

  def index
    @target_penjualan = 100 # Juta
    @pencapaian_sekarang = 75 # Juta
    @persentase = (@pencapaian_sekarang.to_f / @target_penjualan * 100).round
    
    @layanan_aktif = 12 
    @layanan_pending = 3
  end
end