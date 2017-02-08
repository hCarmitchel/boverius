class Guest < ActiveRecord::Base
  validates :last_name, :first_name, presence: true
  validates :first_name, uniqueness: { scope: :last_name, case_sensitive: false,
    message: 'and last name are already in use by a user who has signed up'}
  validate :guest_count, on: :create
  validate :guest_name

  default_scope { order(last_name: :desc) }

  enum role: ['Guest', 'Bride', 'Groomsman', 'Bridesmaid', 'Officiant', 'Best Man', 'Man of Honor', 'Groom'].sort

  belongs_to :user

  def self.below_drinking_age
    Guest.where(below_drinking_age: true).count
  end

  def name
    "#{first_name} #{last_name}"
  end

  def allowed_guests
    0
  end

  def guest_name
    return unless User.find_by(first_name: first_name, last_name: last_name).any?
    self.errors.add('a guest may not have the same name as another user')
  end

  def guest_count
    self.errors.add('your guest count has been reached') unless user.can_invite_guest?
  end
end
