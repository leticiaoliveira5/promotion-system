class CreateProductCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :product_categories do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
    add_index :product_categories, :code, unique: true
  end
end
