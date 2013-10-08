class OrderMailer < ActionMailer::Base
  
  add_template_helper(ApplicationHelper)
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.order_confirmation.subject
  #
  def order_confirmation(order)
    @order = order
    payment_type = @order.payment_type=='cash'?'forskottsbetalning':'kortbetalning'
    subject = "En order är gjord med #{payment_type}"
    mail to: @order.email, bcc: "orderbtfoto@gmail.com", subject: subject, from: "BTfoto webshop<info@btfoto.se>"
  end
end
