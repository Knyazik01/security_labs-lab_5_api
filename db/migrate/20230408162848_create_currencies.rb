class CreateCurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :short_name
      t.string :symbol

      t.timestamps
    end
  end
end
