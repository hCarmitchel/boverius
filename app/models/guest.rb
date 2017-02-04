class Guest < ActiveRecord::Base
  validates :last_name, :first_name, presence: true
  validate :guest_count, on: :create
  validates :first_name, uniqueness: { scope: :last_name, case_sensitive: false,
    message: 'and last name are already in use by a user who has signed up'}


  enum role: [ 'Guest', 'Bride', 'Groomsman', 'Bridesmaid', 'Officiant', "Bride's Escort", 'Vocalist', 'Best Man', 'Man of Honor' ]

  belongs_to :user

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
