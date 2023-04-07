class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.integer :user_id, unique: true

      t.timestamps
    end
  end
end
