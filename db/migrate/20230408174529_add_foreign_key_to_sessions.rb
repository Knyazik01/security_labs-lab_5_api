class AddForeignKeyToSessions < ActiveRecord::Migration[7.0]
  def up
    add_foreign_key :sessions, :users
  end

  def down
    remove_foreign_key :sessions, :users
  end
end
