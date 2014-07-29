module Admin
  class OrdersController < ApplicationController
    
    before_action :authenticate_user, only: [:index, :destroy]
    
    def index
      @search = Order.search(params[:q])
      @orders = @search.result.includes(:order_items).paginate(:page => params[:page], :per_page => 20)
    end
    
    def show
      @order = Order.find(params[:id])
      order_items = OrderItem.where(order_id: @order.id).group(:image_nr).pluck(:image_nr)
      @pictures = @order.order_pictures order_items
      if params[:mail]
        send_order_mail(@order) if params[:mail]
      else
        respond_to do |format|
          format.html
          format.pdf do
            render pdf: "file_name", show_as_html: params[:debug]
          end
        end
      end
    end
    
    def destroy
      @order = Order.find(params[:id])
      @order.destroy
      
      redirect_to admin_orders_path, notice: "Order was destroyed"
    end
    
    def mark_as_printed
      @order = Order.find(params[:order_id])
      @order.mark_as_printed
    end
    
    private
    
    def send_order_mail(order)
      OrderMailer.order_confirmation(order).deliver
      redirect_to admin_orders_path, notice: "Email was sent"
    end
  end
end
