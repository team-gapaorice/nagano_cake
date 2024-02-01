class Item < ApplicationRecord
  belongs_to:genre
  has_many:cart_item, dependent: :destroy
  has_many:order_detail
end
