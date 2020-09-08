class User < ApplicationRecord
  rolify
  devise  :recoverable, 
          :two_factor_authenticatable, 
          :otp_secret_encryption_key => ENV['encrypt_key']
end
