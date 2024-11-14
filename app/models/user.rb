class User < ApplicationRecord

    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }
    validates :email, uniqueness: { case_sensitive: false }
    validates :password, presence: true, confirmation: true # Ensure presence and confirmation of password

     # Role validation
    validates :role, inclusion: { in: %w[user admin], message: "%{value} is not a valid role" }
  
     # Set default role to 'user' if none is provided
    after_initialize :set_default_role, if: :new_record?
   
    private
   
    def set_default_role
       self.role ||= 'user'
    end
end
