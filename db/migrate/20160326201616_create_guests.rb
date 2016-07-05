class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string   :first_name, null: false, default: ''
      t.string   :last_name, null: false, default: ''
      t.string   :role
      t.boolean  :below_drinking_age, null: false, default: false
      t.string   :dietary_restriction
      t.text     :special_instructions
      t.integer  :user_id, null: false
      t.timestamps null: false
    end
  end
end
