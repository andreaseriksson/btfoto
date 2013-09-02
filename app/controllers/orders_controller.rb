class OrdersController < ApplicationController
  
  layout 'frontend'
  
  before_action :load_menu
  before_action :check_login, except: [:login, :auth]
  before_action :initiate_cart
  before_action :load_picture, except: [:login, :auth]
  
  def new
    @order = Order.new
  end
    
  def create  
    @order = Order.new(order_params)
    
    if @order.save
      save_order_items @order, @cart
      
      if @order.payment_type == 'card'
        @payson = Payson.new(@order, @cart)
        render partial: "payson"
      else
        @order.confirm
        OrderMailer.order_confirmation(@order, @cart).deliver
        @cart.destroy
        cookies[:cart_id].destroy
        redirect_to "/store", notice: t('.notice')     
      end
    else
      render action: 'new'
    end
    
  end
  
  private
  
    def order_params
      params.require(:order).permit(:first_name, :family_name, :email, :phone, :address1, :address2, :zip, :city, :payment_type, :extra_shipment)
    end
   
    def save_order_items(order, cart)
      cart.cart_items.each do |cart_item|
        product = Product.find(cart_item.product_id)
        
        order_item = OrderItem.create(order_id: order.id, product_id: cart_item.product_id, quantity: cart_item.quantity, price: product.price, vat: product.vat, discount: product.discount, image_nr: cart_item.image_nr)
        
        order_item.save
      end
    end
    
end