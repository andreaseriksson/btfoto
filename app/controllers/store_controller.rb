class StoreController < ApplicationController

  before_action :load_menu
  before_action :check_login, except: [:login, :auth]
  before_action :initiate_cart
  before_action :load_picture, except: [:login, :auth]

  layout 'frontend'

  def index
    cookies[:product_type] = params[:product_type] if params[:product_type]
    @product_type = cookies[:product_type].to_i ||= nil
    @products = Product.in_category(@picture.product_category_id).belongs_to_product_type(@product_type)
    @product_types = ProductType.new
  end

  def show
    @product = Product.find_by(slug: params[:id])
  end

  def checkout
  end

  def success
  end

  def edit_image
  end

  def update_image
    @picture = Picture.current_image(params[:image_nr]).first

    if @picture
      cookies[:image_nr] = { :value => params[:image_nr], :expires => 60.minutes.from_now }
      cookies.delete :product_type if cookies[:product_type]
      redirect_to store_path, notice: t('store.update_image.notice')
    else
      redirect_to store_edit_image_path, warning: t('store.update_image.warning')
    end
  end

  def switch_image
    cookies[:image_nr] = { :value => params[:image_nr], :expires => 60.minutes.from_now }
    cookies.delete :product_type if cookies[:product_type]
    redirect_to store_path, notice: t('store.switch_image.notice')
  end

  def payment
    @order = Order.new
  end

  def login
    redirect_to store_path if cookies[:image_nr]
  end

  def logout
    cookies.delete :image_nr
    cookies.delete :product_type if cookies[:product_type]
    redirect_to store_login_path
  end

  def auth
    @picture = Picture.current_image(params[:image_nr]).first

    if @picture
      cookies[:image_nr] = { value: @picture.image_nr, expires: 180.minutes.from_now }
      redirect_to store_path, notice: t('store.auth.notice')
    else
      redirect_to store_login_path(error: 'login'), warning: t('store.auth.warning')
    end
  end
end
