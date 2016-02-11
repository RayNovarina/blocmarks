#
module TopicExtensions
  extend ActiveSupport::Concern

  #======== CLASS METHODS, i.e. User.index_action()
  #
  # The code contained within this block will be added to the Class itself.
  # This allows you to do User.index_action(params) instead of
  # User.find_by_email(params[:email]) or other biz logic in the controller.
  module ClassMethods
    # Note: include helper methods for all models, such as return_view_hash_of.
    include ModelHelper # /models/concerns/model_helper.rb
    # Note: controller actions interface:
    # Inputs: url_params = hash of url params from the controller/browser.
    # Return: depends on method or action. Usually a activeRecord is returned.
  end
end
