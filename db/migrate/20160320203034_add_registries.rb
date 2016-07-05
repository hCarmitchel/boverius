class AddRegistries < ActiveRecord::Migration
  def change
    create_table :registries do |t|
      t.string :name, null: false, default: ''
      t.string :url, null: false, default: ''
    end
  end
end
