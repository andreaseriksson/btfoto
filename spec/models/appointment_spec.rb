require 'spec_helper'

describe Appointment do
  it "has a valid factory" do
    build(:appointment).should be_valid
  end
  
  it "is invalid without a label" do
    build(:appointment, label: nil).should_not be_valid
  end
  
  it "is invalid without a start_time" do
    build(:appointment, start_time: nil).should_not be_valid
  end
  
  it "is invalid with a start_time before today" do
    build(:appointment, start_time: Date.yesterday).should_not be_valid
  end  
end
