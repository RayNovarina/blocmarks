#
class User < ActiveRecord::Base
  has_many :topics

  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable, :trackable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
end
