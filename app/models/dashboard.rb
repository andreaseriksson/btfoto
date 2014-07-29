class Dashboard
  
  def unprinted_orders
    Order.unprinted.includes(:order_items)
  end
  
  def last_ten_orders
    Order.includes(:order_items).limit(10)
  end
  
  def grouped_orders
    Order.where('created_at between ? and ?', Date.today, 1.week.ago).group_by { |t| t.created_at.beginning_of_week }.inject({}) {|hash, o| hash[o.first] = o.last.size; hash}
  end
  
  def new_appointments
    Appointment.where(approved: false, booked: true).order('id desc')
  end
  
  def top_selling_products
    Product.joins(:order_items).group('products.id').order('total desc').limit(5).pluck("products.id,products.name, sum(quantity) as total")
  end
  
  def least_selling_products
    Product.joins("LEFT JOIN order_items ON products.id=order_items.product_id").group('products.id').order('total asc').limit(5).pluck("products.id,products.name, sum(quantity) as total")
  end
  
end
