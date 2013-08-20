module Admin
  class ProductCategoriesController < ApplicationController
    before_action :authenticate_user
    
    def index
      @product_categories = ProductCategory.all
    end
    
    def new
      @product_category = ProductCategory.new
    end
    
    def create
      @product_category = ProductCategory.new(product_category_params)
      
      if @product_category.save
        redirect_to admin_product_categories_path, notice: 'Product category was successfully created.'
      else
        render action: "new"
      end
    end
    
    def edit
      @product_category = ProductCategory.find_by(slug: params[:id])
    end
    
    def update
      @product_category = ProductCategory.find_by(slug: params[:id])
  
      if @product_category.update_attributes(product_category_params)
        redirect_to admin_product_categories_path, notice: 'Product category was successfully updated.'
      else
        render action: "edit"
      end
    end
    
    def destroy
      @product_category = ProductCategory.find_by(slug: params[:id])
      @product_category.destroy
      
      redirect_to admin_product_categories_path, :notice => 'Product category was successfully deleted.'
    end
    
    private
    
    def product_category_params
      params.require(:product_category).permit(:name)
    end
    
  end
end