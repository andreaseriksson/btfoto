class PaymentsController < ApplicationController

  before_action :check_login, except: [:login, :auth]
  before_action :initiate_cart

  def create
    @order = Order.where(token: params[:token]).first
    @cart.destroy
    if @order
      @order.confirm
      OrderMailer.order_confirmation(@order).deliver

      begin
        @cart.destroy if defined? @cart
        cookies[:cart_id].destroy if defined? cookies[:cart_id]
      ensure
        redirect_to "/store", notice: t('payments.create.notice')
      end

    else
      redirect_to "/store", warning: t('payments.create.warning')
    end
  end
end
