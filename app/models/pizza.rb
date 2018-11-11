class Pizza < ApplicationRecord
  belongs_to :category
  has_many :orders, dependent: :destroy
  has_many :carts, dependent: :destroy

  validates_presence_of :name, :price, :ingredients, :image
  validates_uniqueness_of :name

  mount_uploader :image, ImageUploader
end
