class Guest < ActiveRecord::Base
  validates :last_name, :first_name, presence: true
  validates :first_name, uniqueness: { scope: :last_name, case_sensitive: false,
    message: 'and last name are already in use by a user who has signed up'}
  validate :guest_count, on: :create
  validate :guest_name

  default_scope { order(last_name: :asc) }

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
    return unless User.find_by(first_name: first_name, last_name: last_name)
    self.errors.add(:base, 'a guest may not have the same name as another user')
  end

  def guest_count
    # self.errors.add(:base, 'your guest count has been reached') unless user.can_invite_guest?
    true
  end
end
