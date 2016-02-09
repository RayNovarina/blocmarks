#
class Bookmark < ActiveRecord::Base
  belongs_to :topic

  validates :title, length: { minimum: 2 }, presence: true
  validates :description, length:  { minimum: 15 }, presence: true
  validates :url, length:  { minimum: 15 }, presence: true
end
