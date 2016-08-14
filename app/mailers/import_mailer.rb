class ImportMailer < ActionMailer::Base

  layout 'base_mailer'

  def notification(email, image)
    @email = email
    @image = image
    subject = 'Din bild är nu tillgänglig'
    mail to: email, subject: subject, from: "BTfoto webshop<info@btfoto.se>"
  end
end
