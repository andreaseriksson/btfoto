class PaymentsController < ApplicationController
  
  before_action :check_login, except: [:login, :auth]
  before_action :initiate_cart
  
  def create
    @order = Order.where(token: params[:token]).first
    
    if @order
      @order.confirm
      OrderMailer.order_confirmation(@order).deliver
      
      @cart.destroy
      cookies[:cart_id].destroy
      redirect_to "/store", notice: t('.notice')
    else
      redirect_to "/store", warning: t('.warning')
    end
  end
end