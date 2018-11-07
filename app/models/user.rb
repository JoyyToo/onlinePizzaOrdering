class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :feedbacks
  has_many :orders

  alias_method :authenticate, :valid_password?

  validates_presence_of :email, :username

  before_save :default_values

  def default_values
    self.roles = 'user' if roles.nil?
  end

end
