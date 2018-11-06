class User < ActiveRecord::Base
  has_many :article
  validates :username, presence: true, 
  uniqueness: {case_sensative: false},
  length: {minimum: 3, maximum: 25}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i 
  
  validates :email, 
  uniqueness: {case_sensative: false},
  format: { with: VALID_EMAIL_REGEX }
  
  
end