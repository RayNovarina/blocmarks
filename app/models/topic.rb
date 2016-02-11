#
class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks, dependent: :destroy

  validates :title, length: { minimum: 2 }, presence: true
  validates :description, length:  { minimum: 2 }, presence: true

  # CLASS and Instance methods that extend the Topic ActiveRecord class via
  # /models/concerns files. And add useful helper routines and to put biz logic
  # in the model and not in controllers.
  # include TopicExtensions # /models/concerns/topic_extensions.rb
end
