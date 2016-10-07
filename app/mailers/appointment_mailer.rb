class AppointmentMailer < ActionMailer::Base

  layout 'base_mailer'

  def booked(appointment_id)
    @appointment = Appointment.find appointment_id
    email = @appointment.email

    subject = 'Din tid är bokad'
    mail to: email, subject: subject, from: "BTfoto webshop<info@btfoto.se>"
  end
end

