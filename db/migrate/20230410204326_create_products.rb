class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.integer :currency_id

      t.timestamps
    end
    add_index :products, :currency_id
  end
end
