require 'rails_helper'

feature 'Book appointment' do
  before(:each) do
    @appointment = create(:appointment, label: 'Booking' )
  end

  scenario 'books an appointment' do
    visit appointments_path
    page.should have_content(@appointment.label)
    first('a.btn').click
    current_path.should eq(edit_appointment_path(@appointment))
  end

end
