class CreatePromotions < ActiveRecord::Migration[5.2]
  def change
    create_table :promotions do |t|
      t.string :name
      t.text :description
      t.string :code
      t.integer :discount_rate
      t.decimal :coupon_quantity
      t.date :expiration_date

      t.timestamps
    end
  end
end
