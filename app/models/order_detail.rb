class OrderDetail < ApplicationRecord
  belongs_to:order
  belongs_to:order_detail
end
