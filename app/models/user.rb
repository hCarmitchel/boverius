class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :rsvps, dependent: :destroy, as: :rsvper
  has_many :guests, dependent: :destroy

  accepts_nested_attributes_for :rsvps

  validate :invite_code_valid, on: :create
  validate :special_instructions_correct

  attr_accessor :invite_code

  def invite_code_valid
    message = 'invalid. Please use the code on your invitation or contact the Bride or Groom'
    self.errors.add(:invite_code, message) unless self.invite_code == 'eatdrink&bemarried2017'
  end

  def self.hotel_rooms
    User.sum(:hotel_rooms)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def registrations
    rsvps.select { |rsvp| rsvp.going }.map(&:rsvp_type)
  end

  def rsvp?
    registrations.any?
  end

  def special_instructions_correct
    return if dietary_restriction.nil? || special_instructions.present?
    message = 'must be filled out for "Allergy" or "Other" dietary restriction types'
    self.errors.add(:special_instructions, message) if ['Allergy', 'Other'].include?(dietary_restriction)
  end
end
