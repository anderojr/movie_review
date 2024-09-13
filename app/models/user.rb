class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, authentication_keys: [:username]

  has_many :movies

  before_save :strip_namespaces

  validates :username, presence: true, uniqueness: true, length: { minimum: 5, maximum: 24 }
  validates :first_name, :last_name, presence: true, on: %i[create update]

  validates :username,
            format: { with: /\A[a-zA-Z0-9._-]+\z/, message: "can only contain letters, numbers, '.', '_', and '-'" }
  validates :first_name, :last_name, format: { with: /\A[ a-zA-Z]+\z/, message: 'can only contain letters and spaces' }

  def new_password_required?
    new_record? || !self[:valid_password]
  end

  private

  def strip_namespaces
    self.first_name = first_name.strip
    self.last_name = last_name.strip
  end
end
