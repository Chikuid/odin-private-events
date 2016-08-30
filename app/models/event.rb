class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"

  has_many :invites, class_name: "Invite",
                    foreign_key: "attended_event_id"
  has_many :attendees, through: :invites,
                        source: :attendee
  validates :creator_id, presence: true

  scope :upcoming, -> { where("Date >= ?", Date.today).order('Date ASC') }
  scope :past, -> { where("Date < ?", Date.today).order('Date DESC') }
end
