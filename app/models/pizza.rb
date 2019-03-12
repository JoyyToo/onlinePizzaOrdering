class Pizza < ApplicationRecord
  belongs_to :category
  has_many :orders, dependent: :destroy
  has_many :carts, dependent: :destroy

  validates_presence_of :name, :price, :ingredients
  validates_uniqueness_of :name, case_sensitive: false

  mount_uploader :image, ImageUploader
end
