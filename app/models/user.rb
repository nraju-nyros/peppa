class User < ApplicationRecord
  has_many :ratings
 
  has_many :likes, dependent: :destroy
  

  acts_as_voter

  validates_presence_of :name,  message: "*Please Enter Your Name"
 

  validates_presence_of :password, message: "Please Enter Your Password"

  validates_confirmation_of :password
  validates :email, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: '*Please Enter Your Email'
  }
  

	devise :database_authenticatable,:registerable,
         :recoverable, :confirmable, :rememberable, :validatable, :lockable, :timeoutable, :trackable,
         :omniauthable, :omniauth_providers => [:google_oauth2, :facebook]
  

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_now
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
     
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      
    end
  end

	def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
  
end
