#
class Bookmark < ActiveRecord::Base
  belongs_to :topic

  validates :title, length: { minimum: 2 }, presence: true
  validates :description, length:  { minimum: 2 }, presence: true
  validates :url, length:  { minimum: 10 }, presence: true

  # CLASS and Instance methods that extend the Bookmark ActiveRecord class via
  # /models/concerns files. And add useful helper routines and to put biz logic
  # in the model and not in controllers.
  include BookmarkExtensions # /models/concerns/bookmark_extensions.rb
end
