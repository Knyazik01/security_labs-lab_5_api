class UpdateFloatColumnsInEWalletsProductsTransactionsToTwoDecimalPlaces < ActiveRecord::Migration[7.0]
  def up
    change_column :e_wallets, :count, :decimal, precision: 10, scale: 2

    change_column :products, :price, :decimal, precision: 10, scale: 2

    change_column :transactions, :balance_before, :decimal, precision: 10, scale: 2
    change_column :transactions, :profit, :decimal, precision: 10, scale: 2
    change_column :transactions, :bill, :decimal, precision: 10, scale: 2
    change_column :transactions, :balance, :decimal, precision: 10, scale: 2
  end

  def down
    change_column :e_wallets, :count, :float

    change_column :products, :price, :float

    change_column :transactions, :balance_before, :float
    change_column :transactions, :profit, :float
    change_column :transactions, :bill, :float
    change_column :transactions, :balance, :float
  end
end
