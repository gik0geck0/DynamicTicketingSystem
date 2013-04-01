class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  attr_accessible :password, :password_confirmation, :email, :first_name, :last_name, :photo
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  has_attached_file :photo,
    :styles => {
      :thumb => "100x100#",
      :small => "150x150>"
    }

  def self.authenticate(email, password)
    puts "Authenticating: ", email, "; ", password
    user = find_by_email(email)
    puts "User is: ", user
    if user
      puts "New encrypted PW:", BCrypt::Engine.hash_secret(password, user.password_salt)
      puts "Compared to: ", user.password_hash
    end

    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    puts "Encrypting password"
    if @password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(@password, self.password_salt)
    end
  end

  def self.get_current_user(user_id)
    if defined? user_id
      return find_by_id(user_id)
    else
      return nil
    end
  end
end
