class RemovePizzaColumns < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :pizzas, :toppings
  end
end
