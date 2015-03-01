class AppointmentsController < ApplicationController

  before_action :load_menu

  layout 'frontend'

  def index
    @appointments = Appointment.order(:start_time)
  end

  def edit
    @appointment = Appointment.find(params[:id])
    redirect_to appointments_path if @appointment.booked
  end

  def update
    @appointment = Appointment.find(params[:id])

    if @appointment.update_attributes(appointment_params)
      @appointment.book!

      redirect_to appointments_path, notice: t('appointments.update.notice')
    else
      render action: "edit"
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:name, :email, :phone)
  end
end
