class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, {
    presence: true,
    length: {minimum: 3, maximum: 30}
  }
  validates :last_name, {
    presence: true,
    length: {minimum: 3, maximum: 30}
  }
  validates :email, {
    presence: true,
    length: {maximum: 30},
    uniqueness: true,
    email: true
  }
end
