require 'rails_helper'

RSpec.describe Appointment, type: :model do

  context 'validations' do
    it 'has a valid factory' do
      appointment = FactoryGirl.build(:appointment)
      expect(appointment).to be_valid
    end

    it 'is invalid without a label' do
      appointment = FactoryGirl.build(:appointment, label: nil)
      expect(appointment).not_to be_valid
    end

    it 'is invalid without a start_time' do
      appointment = FactoryGirl.build(:appointment, start_time: nil)
      expect(appointment).not_to be_valid
    end

    it 'is invalid with a start_time before today' do
      appointment = FactoryGirl.build(:appointment, start_time: Date.yesterday)
      expect(appointment).not_to be_valid
    end
  end

  context 'week' do
    before do
      @appointment = FactoryGirl.build(:appointment)
    end

    it 'should return a week number' do
      expect(@appointment.week).to eq('09')
    end

    it 'gives correct week number on beginning of year' do
      @appointment.start_time = Date.today.beginning_of_year
      expect(@appointment.week).to eq('01')
    end
  end
end
