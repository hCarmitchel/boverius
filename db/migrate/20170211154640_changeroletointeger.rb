class Changeroletointeger < ActiveRecord::Migration[5.0]
  def up
    remove_column :users, :role
    add_column :users, :role, :integer
    remove_column :guests, :role
  end

  def down
  end
end
