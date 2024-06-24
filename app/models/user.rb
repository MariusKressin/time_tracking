class User < ApplicationRecord
  belongs_to :group

  has_many :hours
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Users visible to this user.
  def visible_users
    User.where('role < ?', role)
  end
end
