module Admin
  class PicturesController < ApplicationController
    
    before_action :authenticate_user
    
    def index
      @imports = Picture.group(:folder).pluck(:folder)
      @pictures = Picture.where(folder: params[:folder]) if params[:folder]      
    end
    
    def new
      
    end
    
    def create
      @picture = Picture.new(picture_params)
  
      if @picture.save
        redirect_to admin_pictures_path, notice: 'Picture was successfully created.'
      else
        render action: "new"
      end
    end
    
    
    
    private
    
    def picture_params
      params.require(:picture).permit(:product_category_id, :image)
    end
    
  end
end