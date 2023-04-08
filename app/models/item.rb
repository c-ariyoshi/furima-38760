class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_condition
  belongs_to :prefecture
  belongs_to :shipping_date
  belongs_to :shipping_fee

  validates :name, :description, :category_id, :item_condition_id,
   :prefecture_id, :shipping_fee_id, :shipping_date_id, :user_id, presence: true, unless: :was_attached?
  validates :price, presence: true, unless: :was_attached?, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
    format: { with: /\A[0-9]+\z/, message: '半角数字で入力して下さい'  }
  validates :category_id, :item_condition_id, :prefecture_id, :shipping_fee_id,
  :shipping_date_id, numericality: { other_than: 1 , message: "can't be blank" } 

  def was_attached?
    self.image.attached?
  end

end
