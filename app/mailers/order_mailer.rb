class OrderMailer < ActionMailer::Base
  default from: "test@codered.se"
  add_template_helper(ApplicationHelper)
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.order_confirmation.subject
  #
  def order_confirmation(order,cart)
    @order = order
    @cart = cart
    mail to: "andreas@codered.se", subject: "Order confirmation"
  end
end
