class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable, :trackable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
end
