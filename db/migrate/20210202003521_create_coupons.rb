class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :code
      t.references :promotion, foreign_key: true

      t.timestamps
    end
    add_index :coupons, :code, unique: true
  end
end
