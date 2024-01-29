class OrderDetail < ApplicationRecord
  belong_to:order
  belong_to:order_detail
end
