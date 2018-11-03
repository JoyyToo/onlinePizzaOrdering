class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :feedbacks
  has_many :orders

  alias_method :authenticate, :valid_password?

  validates_presence_of :email, :username, :password

  # def self.from_token_payload(payload)
  #   find payload["sub"]
  #   byebug
  # end

end
