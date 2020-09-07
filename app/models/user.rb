class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable, :rememberable, :validatable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable
end
