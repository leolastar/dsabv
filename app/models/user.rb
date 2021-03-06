class User < ActiveRecord::Base
  has_many :appointments
  has_many :time_slots, through: :appointments
  has_many :class_slots, through: :appointments
  has_many :buddy_slots, through: :appointments
  has_many :events, through: :time_slots
  has_many :buddy_walks, through: :buddy_slots
  has_many :ds_classes, through: :class_slots

  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest

  validates :name,  presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password

  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :address, presence: true, length: {maximum: 100}

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def self.search(search)
    where('lower(name) LIKE ? OR lower(email) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%")
  end

  def appointment(timeslot)
    appointment = Appointment.where(user_id: self.id, time_slot_id: timeslot.id).first
  end

  def appointment_class(class_slot)
    appointment = Appointment.where(user_id: self.id, class_slot_id: class_slot.id).first
  end

  def appointment_buddy(buddy_slot)
    appointment = Appointment.where(user_id: self.id, buddy_slot_id: buddy_slot.id).first
  end
 
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Register an event
  def register(event)
    self.events << event
  end
  
  def register(buddy_walk)
    self.buddy_walks << buddy_walk
  end

private
    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
