class DeliveryDestination < ApplicationRecord
  belongs_to:customer

  def adress_display
  '〒' + postal_code + ' ' + adress + ' ' + name
  end

end
