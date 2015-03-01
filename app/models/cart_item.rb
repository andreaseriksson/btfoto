class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product

  validates :image_nr, presence: true
  validates :cart, presence: true
  validates :product, presence: true

  def update_or_destroy(value)
    if value.to_i > 0
      update(quantity: value)
    else
      destroy
    end
  end

end
