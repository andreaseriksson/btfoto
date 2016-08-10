class OrderMailer < ActionMailer::Base

  add_template_helper(ApplicationHelper)

  layout 'base_mailer'

  def order_confirmation(order)
    @order = order
    payment_type = @order.payment_type == 'cash' ? 'forskottsbetalning' : 'kortbetalning'
    subject = "En order är gjord med #{payment_type}"
    mail to: @order.email, bcc: "orderbtfoto@gmail.com", subject: subject, from: "BTfoto webshop<info@btfoto.se>"
  end
end
