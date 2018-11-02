class AddOrdersToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :users, foreign_key: true
  end
end
