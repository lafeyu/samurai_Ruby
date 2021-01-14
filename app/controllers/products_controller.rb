class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :favorite]
  # PER = 15
  
  def index
    # @products = Product.all
    # @products = Product.page(params[:page]).per(PER)
    # @products = Product.display_list(category_params, params[:page])
    # @category = Category.request_category(category_params)
  if sort_params.present?
      @category = Category.request_category(sort_params[:sort_category])
      @products = Product.sort_products(sort_params, params[:page])
  elsif params[:category].present?
      @category = Category.request_category(params[:category])
      @products = Product.category_products(@category, params[:page])   
  else
      @products = Product.display_list(params[:page])
  end

    @major_category_names = Category.major_categories
    @categories = Category.all
    @sort_list = Product.sort_list
  end

  def show
    @reviews = @product.reviews
    @review = @reviews.new
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to product_url @product
  end

  def edit
    # @categories = Category.all
  end

  def update
    @product.update(product_params)
    redirect_to product_url @product
  end

  def destroy
    @product.destroy
    redirect_to products_url
  end
  
  def favorite
    current_user.toggle_like!(@product)
    redirect_to product_url @product
  end
  
  private
  
    def set_product
         @product = Product.find(params[:id])
    end
  
    def product_params
      params.require(:product).permit(:name, :description, :price, :category_id)
        # 商品データを新規作成するときに、カテゴリの選択と保存ができる

    end
    
     def sort_params
        params.permit(:sort, :sort_category)
     end
end
