class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, authentication_keys: [:username]
  
  validates :username, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true, on: [:create, :update]

  def new_password_required?
    new_record? || !self[:valid_password]
  end

  def update_valid_password!
    update(valid_password: true)
  end
end
