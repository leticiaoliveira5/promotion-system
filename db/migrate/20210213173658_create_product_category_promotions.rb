class CreateProductCategoryPromotions < ActiveRecord::Migration[5.2]
  def change
    create_table :product_category_promotions do |t|
      t.references :product_category, foreign_key: true
      t.references :promotion, foreign_key: true

      t.timestamps
    end
  end
end
