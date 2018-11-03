class RemoveFKey < ActiveRecord::Migration[5.2]
  def change
    remove_reference :orders, :users
  end
end
