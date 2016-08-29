class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  validates :creator_id, presence: true
end
