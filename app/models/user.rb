class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true
  after_initialize :ensure_session_token
  has_many :notes

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    save!
    session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def to_s
    self.email
  end

  def activated?
    self.activated
  end

  def set_activation_token!
    self.activation_token = self.class.generate_session_token
    save!
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def active_user?
    if self.activated == false
      self.errors.messages = "Invalid login credentials!"
    end
  end

end
