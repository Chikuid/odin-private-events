class User < ApplicationRecord

  has_many :events, foreign_key: "creator_id", dependent: :destroy
  has_many :active_invites, class_name: "Invite",
                            foreign_key: "attendee_id",
                            dependent:    :destroy
  has_many :attended_events, through: :active_invites
	before_save { email.downcase! }
	validates :name,  presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
    	              format: { with: VALID_EMAIL_REGEX },
    	              uniqueness: { case_sensitive: false }

    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
  # Follows a user.
  def attend!(event)
    active_invites.create!(attended_event_id: event.id)
  end

  # Unfollows a user.
  def cancel!(event)
    active_invites.find_by(attended_event_id: event.id).destroy
  end

  # Returns true if the current user is following the other user.
  def going?(event)
    attended_events.include?(event)
  end


  # Returns the hash digest of the given string.
  def User.digest(string)
   	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
   		                                          BCrypt::Engine.cost
   	BCrypt::Password.create(string, cost: cost)
  end



end