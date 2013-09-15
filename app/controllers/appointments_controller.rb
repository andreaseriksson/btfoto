class AppointmentsController < ApplicationController
  
  layout 'frontend'
  before_action :load_menu
  
  def index
    @appointments = Appointment.order("start_time asc")
    @days = Appointment.group("DATE(start_time)").order("DATE(start_time) asc").pluck("DATE(start_time)")
  end
  
  def edit
    @appointment = Appointment.find(params[:id])
    redirect_to appointments_path if @appointment.booked
  end
  
  def update
    @appointment = Appointment.find(params[:id])
    
    if @appointment.update_attributes(appointment_params)
      @appointment.booked = true
      @appointment.save
      redirect_to appointments_path, notice: t('.notice')
    else
      render action: "edit"
    end
  end
  
  private
  
  def appointment_params
    params.require(:appointment).permit(:name, :email, :phone)
  end
  
end