class User < ActiveRecord::Base
  include BCrypt
  has_secure_password

  has_many :surveys
  has_many :questions, :through => :surveys

  validates :email, 
            :presence => true, 
            :uniqueness => true,
            :format => { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "%{value} is not a valid email address." }
  validates :password, 
            :presence => true, 
            :length => { in:6..15, 
                         too_short: "Password is too short must be at least 6 characters long",
                         too_long: "Password is too long, can be no more then 15 characters"
                       }
 
end
