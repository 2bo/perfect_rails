class User < ApplicationRecord
    has_secure_password

    validates :email, email: true, uniqueness: true
    validates :password, format: { with: /\A[\p{ascii}&&[^\x20]]{8,72}\z/, allow_nil: true }
end
