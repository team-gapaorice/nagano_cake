class OrderDetail < ApplicationRecord
  belongs_to:order
  belongs_to:item

  enum production_status: { not_available: 0, waiting_for_production: 1, in_production: 2, production_completed: 3 }

  def subtotal
    amount * tax_included_price
  end

end
