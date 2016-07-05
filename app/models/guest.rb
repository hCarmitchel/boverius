class Guest < ActiveRecord::Base
  ROLES = ['Groomsman', 'Bridesmaid', 'Officiant/Bridesmaid', 'Flower Girl', 'Ring Bearer', 'Best Man', 'Maid of Honor'].sort.freeze

  validates :first_name, presence: true, uniqueness: {scope: :last_name}
  validates :last_name, presence: true
  validates :role, inclusion: { in: Guest::ROLES }, allow_blank: true
  validate :special_instructions_correct

  belongs_to :user

  has_many :rsvps, dependent: :destroy, as: :rsvper

  accepts_nested_attributes_for :rsvps

  def name
    "#{first_name} #{last_name}"
  end

  def self.below_drinking_age
    Guest.where(below_drinking_age: true).count
  end

  def registrations
    rsvps.select { |rsvp| rsvp.going }.map(&:rsvp_type)
  end

  def special_instructions_correct
    return if dietary_restriction.nil? || special_instructions.present?
    message = 'must be filled out for "Allergy" or "Other" dietary restriction types'
    self.errors.add(:special_instructions, message) if ['Allergy', 'Other'].include?(dietary_restriction)
  end
end
