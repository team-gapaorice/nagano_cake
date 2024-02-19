class Order < ApplicationRecord
  belongs_to:customer
  has_many:order_details, dependent: :destroy
  validates :name, presence: true
  validates :adress, presence: true
  validates :postal_code, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { awaiting_payment: 0, payment_confirmation: 1, in_production: 2, preparing_to_ship: 3, shipped: 4 }

  def order_calculate(order)
    sum = 0
    order.order_details.each do |f|
      sum += f.amount * f.item.tax_included_price
    end
    return sum
  end
end




