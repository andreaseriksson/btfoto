module Admin
  class OrdersController < ApplicationController

    before_action :authenticate_user, only: [:index, :destroy]
    before_action :load_order, only: [:destroy, :mark_as_printed]

    def index
      @search = Order.search(params[:q])
      @orders = @search.result.includes(:order_items).paginate(page: params[:page], per_page: 20)
    end

    def show
      @order = Order.includes(order_items: :product).find(params[:id])
      order_items = @order.order_items.group(:image_nr).pluck(:image_nr)
      @pictures = @order.order_pictures order_items

      if params[:mail]
        send_order_mail @order
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
      @order.destroy
      redirect_to admin_orders_path, notice: "Order was destroyed"
    end

    def mark_as_printed
      @order.mark_as_printed
    end

    def invoice
      @order = Order.includes(order_items: :product).find(params[:id])

      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "file_name", show_as_html: params[:debug]
        end
      end
    end

    private

    def load_order
      @order = Order.find(params[:id])
    end

    def send_order_mail(order)
      OrderMailer.order_confirmation(order).deliver
      redirect_to admin_orders_path, notice: "Email was sent"
    end
  end
end
