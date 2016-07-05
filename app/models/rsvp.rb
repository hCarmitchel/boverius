class Rsvp < ActiveRecord::Base
  TYPES = ['Wedding', 'Reception', 'Rehearsal'].freeze

  validates :rsvp_type, inclusion: { in: Rsvp::TYPES }
  belongs_to :rsvper, polymorphic: true
end
