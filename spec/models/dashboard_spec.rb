require 'rails_helper'

describe Dashboard do

  before(:all) do
    @orders = []
    15.times { @orders << FactoryGirl.create(:order) }
    @dashboard = Dashboard.new
  end

  it 'returns last 10 orders' do
    expect(@dashboard.last_ten_orders.size).to be 10
  end
end
