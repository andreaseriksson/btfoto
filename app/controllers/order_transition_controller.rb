class OrderTransitionController < ApplicationController

  layout 'order_transition'

  before_action :authenticate_user
  before_action :load_order

  def edit
  end

  def update
    new_status = params[:order][:status]
    if new_status && @order.status != new_status
      @order.update_attribute :status, new_status
      OrderMailer.changed_status.deliver_now(@order.id) if %w(progress sent).include? new_status
    end
  end

  private

  def load_order
    @order = Order.find_by token: params[:id]
  end
end
