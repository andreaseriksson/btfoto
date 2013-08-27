require 'spec_helper'

describe Dashboard do
  
  before(:all) do
    
    @orders = []
    10.times do
      @orders << create(:order)
    end
  end
  
  it 'returns last weeks orders' do
    @orders.length.should be 10
  end
    
  it 'returns all new appointments'
  
  it 'smurf'
    
end