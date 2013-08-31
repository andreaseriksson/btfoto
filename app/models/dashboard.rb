class Dashboard
  
  def last_ten_orders
    Order.limit(10)
  end
  
  def last_weeks_grouped_orders
     Order.group("DATE(exposed_at)")
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