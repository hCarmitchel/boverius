class Address < ActiveRecord::Base
  validates :line_1, :city, :state, :zip_code, presence: true

  belongs_to :user
end
