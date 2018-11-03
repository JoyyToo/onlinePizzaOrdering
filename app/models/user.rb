class User < ApplicationRecord
  has_secure_password # encrypted password

  has_many :orders
end
