class ProjectsController < ApplicationController
  before_action :authorized
  before_action :set_project, only: [:show, :edit, :update, :destroy, :approve]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    @project.status = "Pending Approval" 

    if @project.save
      redirect_to projects_path, notice: "Project Berhasil Dibuat! SVC Code: #{@project.svc_code}. Manager akan segera memeriksa pengajuan Anda."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def approve
    if current_user.role == 'manager'
      @project.update(status: 'Approved', approved_at: Time.current)
      redirect_to projects_path, notice: "Project #{@project.svc_code} telah disetujui secara resmi."
    else
      redirect_to projects_path, alert: "Hanya Manager yang berhak memberikan Approval!"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project berhasil diperbarui."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.soft_delete
    redirect_to projects_url, notice: "Project berhasil dihapus."
  end

  def customers
    # Group approved projects by lead to list their services
    @customers = Lead.joins(:projects)
                     .where(projects: { status: 'Approved' })
                     .distinct
                     .includes(projects: :product)
  end

  private

  def project_params
    params.require(:project).permit(:lead_id, :product_id)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
