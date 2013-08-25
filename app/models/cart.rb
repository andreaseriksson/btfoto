class Cart < ActiveRecord::Base
  has_many :cart_items, -> { includes(:product) }
  
  attr_reader :summary, :image_nr
  attr_writer :image_nr
  
  def summary
    @cart = self
    
    products = []
    total_price = 0
    total_quantity = 0
    total_vat = 0
    total_discount = 0
    total_discount_vat = 0
        
    @cart.cart_items.each do |cart_item|
      price = cart_item.product.price.to_f * (1+(cart_item.product.vat)) || 0
	    quantity = cart_item.quantity.to_i || 0
	    vat = price - cart_item.product.price.to_f || 0
	    
	    total_price = total_price.to_f + (price * quantity) || 0
	    total_quantity = total_quantity.to_i + quantity || 0
	    total_vat = total_vat.to_f + (quantity * vat) || 0
	    
	    if days_left(@cart) >= 0 && cart_item.product.allow_discount
	      total_discount = total_discount.to_f + (price * quantity * 0.1) || 0
	      total_discount_vat = total_discount_vat.to_f + (vat * quantity * 0.1) || 0
	    end
	    
	    products << {id: cart_item.product_id, cart_item_id: cart_item.id, image_nr: cart_item.image_nr, name: cart_item.product.name, price: price, total_price: (price * quantity), quantity: quantity, vat: vat, total_vat: (vat * quantity),discount: nil}
	    
	  end
    
    cart_summary = {}
    cart_summary[:delivery] = delivery(total_price-total_discount)
    cart_summary[:quantity] = total_quantity || 0
    cart_summary[:sum_without_delivery] = total_price || 0
    cart_summary[:sum] = total_price + cart_summary[:delivery] || 0
    cart_summary[:vat] = total_vat || 0
    
    cart_summary[:discount] = total_discount || 0
    cart_summary[:sum_after_discount] = total_price - total_discount || 0
    cart_summary[:vat_after_discount] = total_vat - total_discount_vat || 0
    
    cart_summary[:products] = products;    
    cart_summary
    
  end
  
  def days_left(cart=self)
    
    picture = Picture.current_image(cart.image_nr).first
    
    if picture
      start_date = picture.created_at.to_datetime.end_of_day
      end_date = start_date + 20.days
      today_date = DateTime.now.beginning_of_day
      
      days = end_date-today_date
      days.to_i
    else
      -1
    end  
  end
  
  private
  
  def delivery(sum)
    return 0 if only_freight_free_products == true
    sum < CONFIG[:freight_free] ? CONFIG[:shipping_fee] : 0
  end
  
  def only_freight_free_products
    all_freight_free = true
    @cart.cart_items.each do |cart_item|
      all_freight_free = false if cart_item.product.freight == true
    end
    all_freight_free
  end
  
  def to_curr(num)
    number_with_precision(num, locale: :fr, scale: 2)
  end
  
end