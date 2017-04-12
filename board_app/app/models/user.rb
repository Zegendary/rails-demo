class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates_format_of :email, :with => /\A.+@.+\Z/i
  validates :password, presence: true, confirmation: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true

end