class OrderMailer < ActionMailer::Base

  add_template_helper(ApplicationHelper)

  layout 'base_mailer'

  def order_confirmation(order)
    @order = order
    payment_type = @order.payment_type == 'cash' ? 'forskottsbetalning' : 'kortbetalning'
    subject = "Orderbekräftelse: #{payment_type}"
    mail to: @order.email, bcc: "orderbtfoto@gmail.com", subject: subject, from: "BTfoto webshop<info@btfoto.se>"
  end

  def changed_status(order_id)
    @order = Order.find order_id
    return unless %w(progress sent).include? @order.status

    subject = @order.status == 'progress' ? 'Din order behandlas' : 'Din order är redo att skickas'
    mail to: @order.email, bcc: "orderbtfoto@gmail.com", subject: subject, from: "BTfoto webshop<info@btfoto.se>"
  end
end
