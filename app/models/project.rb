class Project < ApplicationRecord
  belongs_to :lead
  belongs_to :product
  belongs_to :user

  # Jalankan fungsi ini sebelum data disimpan ke database
  before_create :generate_svc_code
  
  # Set default status saat project baru dibuat
  before_create :set_default_status

  private

  def generate_svc_code
    # Format: SVC - TahunBulan - RandomString (Contoh: SVC-202601-X7K2)
    timestamp = Time.current.strftime("%Y%m")
    random_id = SecureRandom.alphanumeric(4).upcase
    self.svc_code = "SVC-#{timestamp}-#{random_id}"
  end

  def set_default_status
    self.status ||= "Pending Approval"
  end
end