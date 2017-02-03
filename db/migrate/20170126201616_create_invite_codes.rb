class CreateInviteCodes < ActiveRecord::Migration
  def change
    create_table :invite_codes do |t|
      t.string   :value, null: false
      t.integer  :guests, null: false, default: 1
    end
  end
end
