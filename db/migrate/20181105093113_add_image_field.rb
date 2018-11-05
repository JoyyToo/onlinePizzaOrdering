class AddImageField < ActiveRecord::Migration[5.2]
  def change
    add_column :pizzas, :image, :text
  end
end
