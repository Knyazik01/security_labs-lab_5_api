class RemoveBalanceFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :balance, :float
  end
end
