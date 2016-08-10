class ImportMailer < ActionMailer::Base

  layout 'base_mailer'

  def notification(email, image)
    @email = email
    @image = image
    subject = "Your image is available"
    mail to: 'andreas@codered.se', subject: subject, from: "BTfoto webshop<info@btfoto.se>"
  end
end
