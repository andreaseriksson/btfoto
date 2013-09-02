class StoreController < ApplicationController
  
  layout 'frontend'
  
  before_action :load_menu
  before_action :check_login, except: [:login, :auth]
  before_action :initiate_cart
  before_action :load_picture, except: [:login, :auth]
  
  def index
    @products = Product.in_category @picture.product_category_id
  end
  
  def show
    @product = Product.find_by(slug: params[:id])
  end
  
  def checkout
  end
  
  def edit_image
  end
  
  def update_image
    @picture = Picture.where(name: params[:image_nr]).order(:letter).first
      
    if @picture    
      cookies[:image_nr] = { :value => params[:image_nr], :expires => 60.minutes.from_now }
      redirect_to store_path, notice: t('.notice')
    else
      redirect_to store_edit_image_path, warning: t('.warning')
    end
  end
  
  def switch_image
    cookies[:image_nr] = { :value => params[:image_nr], :expires => 60.minutes.from_now }
    redirect_to store_path, notice: t('.notice')
  end
  
  def payment
    @order = Order.new
  end
  
  def login
    redirect_to store_path if cookies[:image_nr]
  end
  
  def logout
    cookies.delete :image_nr
    redirect_to store_login_path
  end
  
  def auth
    @picture = Picture.current_image(params[:image_nr]).first
    
    if @picture
      cookies[:image_nr] = { :value => @picture.image_nr, :expires => 180.minutes.from_now }
      redirect_to store_path, notice: t('.notice')
    else
      redirect_to store_login_path, warning: t('.warning')
    end
  end
  
  
  
end