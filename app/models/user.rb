class User < ApplicationRecord

    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }
    validates :email, uniqueness: { case_sensitive: false }
    validates :password, presence: true, confirmation: true # Ensure presence and confirmation of password
end
