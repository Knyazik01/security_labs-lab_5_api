class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :currency, null: false, foreign_key: true
      t.float :balance_before
      t.float :profit
      t.float :bill
      t.float :balance

      t.timestamps
    end
  end
end
