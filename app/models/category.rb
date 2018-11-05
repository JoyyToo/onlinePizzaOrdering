class Category < ApplicationRecord
  has_many :pizzas
  validates :name, presence: true
  validates_uniqueness_of :name
end
