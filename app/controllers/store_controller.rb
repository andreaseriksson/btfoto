class StoreController < ApplicationController
  
  layout 'frontend'
  
  before_action :load_menu
  before_action :check_login, except: [:login, :auth]
  before_action :initiate_cart
  before_action :load_picture, except: [:login, :auth]
  
  def index
    @products = Product.all
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
      redirect_to store_path, notice: "Du har nu bytt bildnummer"
    else
      redirect_to store_edit_image_path, warning: "Det gick inte att byta bild till det angivna bildnummret"
    end
  end
  
  def switch_image
    cookies[:image_nr] = { :value => params[:image_nr], :expires => 60.minutes.from_now }
    redirect_to store_path, notice: "Du har nu bytt visningsbild"
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
    @picture = Picture.current_image params[:image_nr] 
    
    if @picture
      cookies[:image_nr] = { :value => @picture.image_nr, :expires => 60.minutes.from_now }
      redirect_to store_path, notice: "Du är nu inloggad"
    else
      redirect_to store_login_path, warning: "Det gick inte att logga in med dina uppgifter"
    end
  end
  
  
  
end