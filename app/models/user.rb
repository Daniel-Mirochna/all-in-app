class User < ApplicationRecord
  has_many_attached :files
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
          :recoverable, :rememberable, :validatable
end
