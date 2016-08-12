class Order < ActiveRecord::Base
  SHIPPING_FEE = 33
  PREPAID_FEE = 19
  FREIGHT_FREE = 650
  DISCOUNT_DAYS = 20

  enum status: { received: 0, unpayed: 1, progress: 2, sent: 3, payed: 4 }

  validates :first_name,  presence: true, length: { minimum: 2 }
  validates :family_name,  presence: true, length: { minimum: 2 }
  validates :phone,  presence: true, length: { minimum: 2 }
  validates :email,  presence: true, format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, multiline: true }
  validates :address1,  presence: true, length: { minimum: 2 }
  validates :zip,  presence: true, length: { minimum: 2 }
  validates :city,  presence: true, length: { minimum: 2 }

  has_many :order_items

  before_create { generate_token }

  default_scope -> { order(created_at: :desc) }
  scope :unprinted, -> { where(printed_at: nil) }

  ransacker :full_name do |parent|
    Arel::Nodes::InfixOperation.new('||',
      Arel::Nodes::InfixOperation.new('||',
        parent.table[:first_name], Arel::Nodes.build_quoted(' ')
      ), parent.table[:family_name]
    )
  end

  def confirm
    update_attribute :confirmed, true
  end

  def order_pictures(order_items)
    pictures = []
    order_items.each do |order_item|
      pictures << Picture.current_image(order_item).first
    end
    pictures
  end

  def summary
    order = self
    order_items = []

    sum_with_vat = 0
    sum_vat = 0
    prepaid_fee = 0
    delivery = order.shipping_cost
    extra_shipment = 0

    if extra_shipment == true
      delivery = delivery - SHIPPING_FEE
      extra_shipment = SHIPPING_FEE
    end

    order_items.each do |order_item|
      sum_with_vat = sum_with_vat + order_item.total
      sum_vat = sum_vat + (order_item.vat * order_item.quantity)
    end

    prepaid_fee = PREPAID_FEE if payment_type == 'cash'

    summary = {}
    summary[:sum_without_delivery] = sum_with_vat + prepaid_fee
    summary[:sum] = sum_with_vat + delivery + prepaid_fee + extra_shipment
    summary[:vat] = sum_vat
    summary[:delivery] = delivery
    summary[:extra_shipment] = extra_shipment
    summary[:prepaid_fee] = prepaid_fee
    summary
  end

  def order_nr
    id + 3200
  end

  def mark_as_printed
    update_attribute :printed_at, Time.now
  end

  private

  def generate_token
	  begin
      self[:token] = SecureRandom.urlsafe_base64
    end while Order.exists?(token: self[:token])
	end
end
