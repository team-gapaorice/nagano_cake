class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many:delivery_destinations, dependent: :destroy
  has_many:cart_items, dependent: :destroy
  has_many:orders, dependent: :destroy

  def own_adress_display
  '〒' + postal_code + ' ' + adress + '  ' + last_name + first_name
  end

end
