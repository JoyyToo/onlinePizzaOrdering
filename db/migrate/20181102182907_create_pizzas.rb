class CreatePizzas < ActiveRecord::Migration[5.2]
  def change
    create_table :pizzas do |t|
      t.float :price
      t.string :name
      t.jsonb :ingredients, default: [], array: true
      t.string :toppings
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
