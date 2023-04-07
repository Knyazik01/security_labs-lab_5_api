class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :login, unique: true, null: false
      t.string :password_digest
      t.float :balance, default: 0, null: false

      t.timestamps
    end
  end
end
