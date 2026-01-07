class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    @project.status = "Pending Approval" # Paksa status awal

    if @project.save
      # Simulasi Notifikasi: Di dunia nyata ini bisa kirim Email/WhatsApp
      redirect_to projects_path, notice: "Project Berhasil Dibuat! SVC Code: #{@project.svc_code}. Manager akan segera memeriksa pengajuan Anda."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def approve
    if current_user.role == 'manager'
      @project = Project.find(params[:id])
      @project.update(status: 'Approved', approved_at: Time.current)
      redirect_to projects_path, notice: "Project #{@project.svc_code} telah disetujui secara resmi."
    else
      redirect_to projects_path, alert: "Hanya Manager yang berhak memberikan Approval!"
    end
  end

  private

  def project_params
    params.require(:project).permit(:lead_id, :product_id)
  end
end