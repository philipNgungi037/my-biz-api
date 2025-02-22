class ProductsController < ApplicationController
    skip_before_action :authorized, only: [:index]
    before_action :set_product, only: [:show, :update, :destroy]
    before_action :authorize_admin, only: [:create, :update, :destroy]

    # GET /products
  def index
    products = Product.includes(:category).all
    render json: products.as_json(include: :category)
  end

  # GET /products/:id
  def show
    render json: @product, serializer: ProductSerializer
  end

  # POST /products
  def create
    category = Category.find_by(id: product_params[:category_id])
    return render json: { error: 'Category not found' }, status: :unprocessable_entity unless category

    product = category.products.build(product_params.except(:category_id))
    if product.save
      render json: product, status: :created
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/:id
  def update
    if @product.update(product_params)
      render json: @product, serializer: ProductSerializer
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
    head :no_content
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :image_url, :category_id)
  end

  def authorize_admin
    # unless current_user&.admin?
    unless current_user.role == 'admin'
      render json: { error: 'Access denied' }, status: :forbidden
    end
  end
end
