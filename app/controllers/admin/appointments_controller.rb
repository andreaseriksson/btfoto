module Admin
  class AppointmentsController < ApplicationController
    
    def index
      @appointments = Appointment.all
    end
    
    def new
      @appointment = Appointment.new
    end
    
    def create
      @appointment = Appointment.new(appointment_params)
  
      if @appointment.save
        redirect_to admin_appointments_path, notice: 'Appointment was successfully created.'
      else
        render action: "new"
      end
    end
    
    def edit
      @appointment = Appointment.find(params[:id])
    end
    
    def update
      @appointment = Appointment.find(params[:id])
  
      if @appointment.update_attributes(appointment_params)
        redirect_to admin_appointment_path, notice: 'Appointment was successfully updated.'
      else
        render action: "edit"
      end
    end
    
    def destroy
      @appointment = Appointment.find(params[:id])
      @appointment.destroy
      
      redirect_to admin_appointment_path, :notice => 'Appointment was successfully deleted.'
    end
    
    private
    
    def appointment_params
      params.require(:appointment).permit(:label, :start_time, :approved, :booked, :name, :email, :phone)
    end
      
  end
end