class Oder < ApplicationRecord
  belong_to:customer
  has_many:order_detail, dependent: :destroy
end
