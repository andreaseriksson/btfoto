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
    @order.shipping_cost = calc_shipping_cost(@order, @cart)
    
    if @order.save
      save_order_items @order, @cart
      
      if @order.payment_type == 'card'
        @payson = Payson.new(@order, @cart)
        render partial: "payson"
      else
        @order.confirm
        OrderMailer.order_confirmation(@order).deliver
        @cart.destroy
        cookies.delete :cart_id
        redirect_to store_success_path(type: 'cash'), notice: t('orders.create.notice')     
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
      cart.summary[:products].each do |cart_row|
        cart_item = CartItem.find(cart_row[:cart_item_id])
        
        order_item = OrderItem.create(
          order_id: order.id, 
          product_id: cart_item.product_id, 
          quantity: cart_row[:quantity], 
          price: cart_row[:price], 
          vat: cart_row[:vat], 
          discount: cart_row[:discount], 
          image_nr: cart_row[:image_nr]
          )
      end
    end
    
    def calc_shipping_cost(order, cart)
      shipping_cost = cart.summary[:delivery]
      shipping_cost = shipping_cost + CONFIG[:shipping_fee] if order.extra_shipment == true
      shipping_cost
    end
    
end