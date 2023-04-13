class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_condition
  belongs_to :prefecture
  belongs_to :shipping_date
  belongs_to :shipping_fee

  validates :image, presence: true
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :category_id, presence: true, numericality: { other_than: 1, message:"can't be blank" }
  validates :item_condition_id, presence: true, numericality: { other_than: 1, message:"can't be blank" }
  validates :prefecture_id, presence: true, numericality: { other_than: 1, message:"can't be blank" }
  validates :shipping_fee_id, presence: true, numericality: { other_than: 1, message:"can't be blank" }
  validates :shipping_date_id, presence: true, numericality: { other_than: 1, message:"can't be blank" }
  validates :price, presence: true, numericality: { only_integer:true,greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message:"is out of setting range" }
  # "is invalid.Input half-width caracters" 

end