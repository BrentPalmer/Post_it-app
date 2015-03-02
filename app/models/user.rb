class User < ActiveRecord::Base
  include Slugable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 5}

  slugable_column :username

  def two_factor_auth?
    !self.phone.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6)) #random 6 digit number
  end

  def remove_pin!
    self.update_column(:pin, nil) 
  end

  def send_pin_to_twilio
    # put your own credentials here 
    account_sid = 'ACda665813e0f0b46d274e4738d07b7c57' 
    auth_token = '7fd276a5d54acc93ca76b32629df7c69' 
     
    # set up a client to talk to the Twilio REST API 
    client = Twilio::REST::Client.new account_sid, auth_token 
     
    msg = "Hi, please enter the pin to continue login: #{self.pin}"
    account = client.account
    message = account.sms.messages.create({
      :from => '+18589265715', :to => '+18587298457'
    })
  end

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator'
  end
end