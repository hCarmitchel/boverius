class AddNameIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :users, [:first_name, :last_name], unique: true
    add_index :guests, [:first_name, :last_name], unique: true
  end
end
