#
class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks, dependent: :destroy

  validates :title, length: { minimum: 2 }, presence: true
  validates :description, length:  { minimum: 15 }, presence: true
end
