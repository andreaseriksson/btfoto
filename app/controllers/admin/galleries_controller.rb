module Admin
  class GalleriesController < ApplicationController
    
    def index
      @galleries = Gallery.all
    end
    
    def new
      @gallery = Gallery.new
    end
    
    def create
      @gallery = Gallery.new(gallery_params)
  
      if @gallery.save
        redirect_to admin_galleries_path, notice: 'Gallery was successfully created.'
      else
        render action: "new"
      end
    end
    
    def edit
      @gallery = Gallery.find(params[:id])
    end
    
    def update
      @gallery = Gallery.find(params[:id])
  
      if @gallery.update_attributes(gallery_params)
        redirect_to admin_galleries_path, notice: 'Gallery was successfully updated.'
      else
        render action: "edit"
      end
    end
    
    def destroy
      @gallery = Gallery.find(params[:id])
      @gallery.destroy
      
      redirect_to admin_galleries_path, :notice => 'Gallery category was successfully deleted.'
    end
    
    def move_higher
      @gallery = Gallery.find(params[:gallery_id])
      @gallery.move_higher if @gallery
            
      redirect_to admin_galleries_path, :notice => 'Gallery was successfully deleted.'
    end
    
    def move_lower
      @gallery = Gallery.find(params[:gallery_id])
      @gallery.move_lower if @gallery
            
      redirect_to admin_galleries_path, :notice => 'Gallery was successfully deleted.'
    end
    
    private
    
    def gallery_params
      params.require(:gallery).permit(:image)
    end
  end
end