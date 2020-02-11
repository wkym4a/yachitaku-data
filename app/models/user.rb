class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #新規登録は不可に
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
end
