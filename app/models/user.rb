class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum hotel: ['Coco Beach Hotel', 'Bosque Del Mar', 'Hiatt', 'Other']
  enum food_preference: ['Fish', 'Beef', 'Vegetarian', 'Kids meal']
  enum role: ['Guest', 'Bride', 'Groomsman', 'Bridesmaid', 'Officiant', 'Best Man', 'Man of Honor', 'Groom']

  has_many :guests, dependent: :destroy
  has_one :address, dependent: :destroy
  belongs_to :invite_code

  validates :last_name, :first_name, presence: true
  validate :invite_code_valid, on: :create
  validates :first_name, uniqueness: { scope: :last_name, case_sensitive: false,
    message: 'and last name are already in use by a user who has signed up'}

  default_scope { order(last_name: :asc) }

  accepts_nested_attributes_for :address

  attr_accessor :invite_code

  def invite_code_valid
    if InviteCode.find_by(value: self.invite_code)
      self.invite_code_id = InviteCode.find_by(value: self.invite_code).id
    else
      self.errors.add(:invite_code, 'invalid. Please use the code on your invitation or contact the Bride or Groom')
    end
  end

  def can_invite_guest?
    guests.count < InviteCode.find(invite_code_id).guests
  end

  def self.hotel_rooms
    User.sum(:hotel_rooms)
  end

  def allowed_guests
    InviteCode.find(invite_code_id).guests - 1
  end

  def remaining_invites
    allowed_guests - guests.count
  end

  def name
    "#{first_name} #{last_name}"
  end

  def role_class(role)
    (self.role == role) && 'current_role'
  end
end
