class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, authentication_keys: [:username]
  
  validates :username, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true, on: [:create, :update]
end
