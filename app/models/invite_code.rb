class InviteCode < ActiveRecord::Base
  has_many :users

  default_scope { order(guests: :asc) }

  before_destroy :not_in_use

  protected

  def not_in_use
    if User.where(invite_code_id: id)
      self.errors.add(:base, 'invite code is in use and cannot be deleted')
      false
    end
  end
end
