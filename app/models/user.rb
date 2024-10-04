class User < ApplicationRecord


    has_secure_password # Adds methods to set and authenticate against a BCrypt password

      # Define user roles (regular user = 0, admin = 1)
    enum role: { user: 0, admin: 1 }

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
