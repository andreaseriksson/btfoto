class PaymentsController < ApplicationController
  
  before_action :check_login, except: [:login, :auth]
  before_action :initiate_cart
  
  def create
    
    @order = Order.where(token: params[:token]).first
    
    if @order
      @order.confirm
      OrderMailer.order_confirmation(@order, @cart).deliver
      
      raise @cart.summary[:products][0][:image_nr].inspect 
      
      @cart.destroy
      cookies[:cart_id].destroy
      redirect_to "/store", notice: 'Order was successfully created.'
    else
      redirect_to "/store", warning: 'There was something wrong with your order.'
    end
  end
end