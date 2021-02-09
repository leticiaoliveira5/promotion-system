class CreatePromotionApprovals < ActiveRecord::Migration[5.2]
  def change
    create_table :promotion_approvals do |t|
      t.references :user, foreign_key: true
      t.references :promotion, foreign_key: true

      t.timestamps
    end
  end
end
