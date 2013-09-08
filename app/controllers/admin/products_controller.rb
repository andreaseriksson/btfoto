module Admin
  class ProductsController < ApplicationController
    helper_method :sort_column, :sort_direction
    before_action :authenticate_user
    
    def index
      @products = Product.order(sort_column + " " + sort_direction)
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
      params.require(:product).permit(:name, :description, :price, :vat, :image, :discount, :allow_discount, :freight, :product_type, :product_category_ids => [])
    end
    
    
    def sort_column
      Product.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    
  end
end