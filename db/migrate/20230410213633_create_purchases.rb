class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.integer :user_id, foreign_key: true
      t.integer :product_id, foreign_key: true

      t.timestamps
    end
  end
end
