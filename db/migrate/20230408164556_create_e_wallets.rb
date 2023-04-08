class CreateEWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :e_wallets do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.integer :currency_id, null: false, foreign_key: true
      t.float :count, default: 0

      t.timestamps
    end
  end
end
