class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.string :rsvp_type, null: false, default: ''
      t.boolean :going, null: false, default: false
      t.integer :rsvper_id, null: false
      t.string :rsvper_type, null: false
      t.timestamps null: false
    end
  end
end
