class User < ActiveRecord::Base
  attr_accessible :username, :password, :session_token

  before_validation(:ensure_session_token, on: :create)

  validates :session_token, :username, presence: true

  has_many :cats,
           :foreign_key => :user_id,
           :primary_key => :id,
           :class_name => "Cat"

  # has_many :session_tokens,
  #          :foreign_key => :user_id,
  #          :primary_key => :id,
  #          :class_name => "SessionToken"

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end
  #
  def delete_session
    self.session_token.delete()

  end
    #
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end


end
