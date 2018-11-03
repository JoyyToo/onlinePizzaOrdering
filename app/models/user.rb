class User < ApplicationRecord
  has_secure_password # encrypted password

  has_many :orders
  has_many :feedbacks
end
