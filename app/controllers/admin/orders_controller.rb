module Admin
  class OrdersController < ApplicationController
    
    before_action :authenticate_user, only: [:index, :destroy]
    
    def index
      @orders = Order.paginate(:page => params[:page], :per_page => 10)
    end
    
    def show
      @order = Order.find(params[:id])
      order_items = OrderItem.where(order_id: @order.id).group(:image_nr).pluck(:image_nr)
      @pictures = Picture.where(name: order_items)
      
      #raise @pictures.inspect
      
      respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "file_name", :show_as_html => params[:debug]
        end
      end
      
    end
    
    def destroy
      @order = Order.find(params[:id])
      @order.destroy
      
      redirect_to admin_orders_path, notice: "Order was destroyed"
    end
        
  end
end