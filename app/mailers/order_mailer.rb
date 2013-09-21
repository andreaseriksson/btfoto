class OrderMailer < ActionMailer::Base
  
  add_template_helper(ApplicationHelper)
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.order_confirmation.subject
  #
  def order_confirmation(order,cart)
    @order = order
    @cart = cart
    payment_type = @order.payment_type=='cash'?'forskottsbetalning':'kortbetalning'
    subject = "En order är gjord med #{payment_type}"
    mail to: "andreas@codered.se", subject: subject
    #mail to: "info@btfoto.se", subject: subject, bcc: "andreas@codered.se"
  end
end
