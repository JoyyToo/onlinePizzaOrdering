class Order < ApplicationRecord
  belongs_to :pizza
  belongs_to :user

  validates_presence_of :quantity

  before_save :default_values

  def default_values
    self.status = 'pending' if status.nil?
  end
end
