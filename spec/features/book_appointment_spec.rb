require 'spec_helper'

feature 'Book appointment' do
  before(:each) do
    @_appointment = create(:appointment, label: 'Booking' )
  end
  
  scenario 'books an appointment' do
    visit appointments_path
    page.should have_content(@_appointment.label)
    first('a.btn').click
    current_path.should eq(edit_appointment_path(@_appointment))
  end
    
end