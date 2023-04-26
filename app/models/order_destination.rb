class OrderDestination
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :address, :building_name, :phone_number

  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid"}
    validates :prefecture_id
    validates :city
    validates :address
    validates :phone_number, numericality: { only_integer: true, message: "is invalid.Input only number"}
    validates :phone_number, format: { with:/\A\d{10}$|^\d{11}\z/, message: "is too short" }
    validates :user_id
    validates :item_id
  end

  with_options numericality: { other_than: 1 } do
    validates :prefecture_id
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Destination.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number)
  end
end