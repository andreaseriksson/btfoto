class Dashboard
  
  def last_ten_orders
    Order.limit(10)
  end
  
end