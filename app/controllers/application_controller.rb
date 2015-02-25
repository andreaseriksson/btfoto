class ApplicationController < ActionController::Base
  include Monban::ControllerHelpers
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout 'backend'

  private

  def authenticate_user
    redirect_to admin_login_path unless signed_in?
  end

  def current_image_nr
    @current_image_nr ||= cookies[:image_nr] if cookies[:image_nr]
  end
  helper_method :current_image_nr

  def check_login
    redirect_to "/store/login" if current_image_nr.nil?
  end

  def load_menu
    @pages = Page.roots.where(active: true)
  end

  def initiate_cart
    @cart ||= Cart.where(id: cookies[:cart_id]).first_or_create
    @cart.image_nr = cookies[:image_nr]
    cookies[:cart_id] = @cart.id unless cookies[:cart_id]
  end

  def days_left
    #Görs efter pictures
  end

  def load_picture
    @picture ||= Picture.current_image(cookies[:image_nr]).first if cookies[:image_nr]
  end
end
