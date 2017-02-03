class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string   :first_name, null: false, default: ''
      t.string   :last_name, null: false, default: ''
      t.integer  :role, null: false, default: 0
      t.boolean  :below_drinking_age, null: false, default: false
      t.integer  :food_preference
      t.text     :allergy
      t.integer  :user_id, null: false
      t.timestamps null: false
    end
  end
end
