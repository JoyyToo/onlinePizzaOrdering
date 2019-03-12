class Category < ApplicationRecord
  has_many :pizzas, dependent: :destroy
  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false
end
