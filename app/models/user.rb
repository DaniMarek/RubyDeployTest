class User < ActiveRecord::Base
   has_secure_password

   has_many :joins
   has_many :songs, through: :joins
   # to get to songs, has to go through joins
  
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  before_save :downcase
  # changes inputs to lowercase letters. this will help avoid errors and case sensitivity
  validates :first_name, :last_name, presence: true, length: { in: 2..20 }
  validates :email, presence: true, format: { with:EMAIL_REGEX }

  private
  	def downcase
  		self.first_name.downcase!
  		self.last_name.downcase!
  		self.email.downcase!
  	end
end
