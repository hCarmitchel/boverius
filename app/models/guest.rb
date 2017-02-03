class Guest < ActiveRecord::Base
  validates :first_name, presence: true, uniqueness: {scope: :last_name}
  validates :last_name, presence: true

  enum role: [ 'Guest', 'Bride', 'Groomsman', 'Bridesmaid', 'Officiant', "Bride's Escort", 'Vocalist', 'Best Man', 'Man of Honor' ]

  belongs_to :user

  validate :guest_count, on: :create

  def self.below_drinking_age
    Guest.where(below_drinking_age: true).count
  end

  def name
    "#{first_name} #{last_name}"
  end

  def guest_count
    self.errors.add('your guest count has been reached.') unless user.can_invite_guest?
  end
end
