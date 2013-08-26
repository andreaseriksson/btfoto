require 'spec_helper'

describe User do
  
  let(:user) { FactoryGirl.create(:user) }
  
  it "has a valid factory" do
    user.should be_valid
  end
  
  it "is invalid whithout an email" do
    user = FactoryGirl.build(:user, email: nil)
    user.should_not be_valid
  end
  
  it "is invalid with wrong format email" do
    FactoryGirl.build(:user, email: "Smurf").should_not be_valid
  end
  
  it "does not allow duplicate emails" do
    FactoryGirl.create(:user, email: "foo@foo.com")
    FactoryGirl.build(:user, email: "foo@foo.com").should_not be_valid
  end
  
  it "is invalid without pasword" do
    FactoryGirl.build(:user, password: nil).should_not be_valid
  end
  
  it "is invalid with short pasword" do
    FactoryGirl.build(:user, password: "foo").should_not be_valid
  end  
  
end