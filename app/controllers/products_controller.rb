class ProductsController < ApplicationController
  # Memastikan data produk diambil sebelum aksi tertentu
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  # Hanya Manager yang bisa memodifikasi data
  before_action :authorize_manager!, except: [:index, :show]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: "Layanan baru berhasil ditambahkan."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: "Data layanan berhasil diperbarui."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.soft_delete
    redirect_to products_path, notice: "Layanan telah dihapus dari katalog."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end

  def authorize_manager!
    unless current_user.role == 'manager'
      redirect_to products_path, alert: "Akses Dibatalkan: Anda bukan Manager."
    end
  end
end