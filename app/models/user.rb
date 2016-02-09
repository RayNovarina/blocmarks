#
class User < ActiveRecord::Base
  has_many :topics, dependent: :destroy

  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable, :trackable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  # validates :name, length: { minimum: 1, maximum: 100 }, presence: true
end
