class User < ActiveRecord::Base
  validates_length_of :password, :within => 5..40
  validates_presence_of :email, :password, :password_confirmation, :salt
  validates_confirmation_of :password
  validates_uniqueness_of :email

  attr_protected :id, :salt
  attr_accessor :password, :password_confirmation

  def self.authenticate(email, pass)
    u = find(:first, :conditions=>["email = ?", email]) # TODO: new fangled find syntax?
    return u if u and User.encrypt(pass, u.salt) == u.password_hash
    nil
  end

  def password=(pass)
    @password=pass
    self.salt = User.random_string(10) if !self.salt?
    self.password_hash = User.encrypt(@password, self.salt)
  end
 
  def send_new_password
    new_pass = User.random_string(10)
    self.password = self.password_confirmation = new_pass
    self.save
    Notifications.deliver_forgot_password(self.email, new_pass)
  end

  protected
   
  def self.encrypt(pass, salt)
   Digest::SHA1.hexdigest(pass+salt)
  end

  def self.random_string(len)
     #generate a random password consisting of strings and digits
     chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
     newpass = ""
     1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
     return newpass
  end
    
end
