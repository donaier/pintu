class User < ApplicationRecord
  rolify
  acts_as_messageable
  devise  :recoverable,
          :two_factor_authenticatable,
          :otp_secret_encryption_key => ENV['encrypt_key']

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
end
