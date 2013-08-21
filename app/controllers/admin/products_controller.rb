module Admin
  class ProductsController < ApplicationController
    
    before_action :authenticate_user
    
    def index
      @products = Product.all
    end
    
    def new
      @product = Product.new
    end
    
    def create
      @product = Product.new(product_params)
  
      if @product.save
        redirect_to admin_products_path, notice: 'Product was successfully created.'
      else
        render action: "new"
      end
    end
    
    def edit
      @product = Product.find_by(slug: params[:id])
    end
    
    def update
      @product = Product.find_by(slug: params[:id])
  
      if @product.update_attributes(product_params)
        redirect_to admin_products_path, notice: 'Product category was successfully updated.'
      else
        render action: "edit"
      end
    end
    
    def destroy
      @product = Product.find_by(slug: params[:id])
      @product.destroy
      
      redirect_to admin_products_path, :notice => 'Product category was successfully deleted.'
    end
    
    private
    
    def product_params
      params.require(:product).permit(:name, :description, :price, :vat, :image, :discount, :allow_discount, :freight, :product_category_ids => [])
    end
    
  end
end