class Account < ApplicationRecord
    has_secure_password
    validates :full_name, presence: true
    validates :email, presence: true, uniqueness: true
    has_many :posts
end
