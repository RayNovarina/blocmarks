#
class LikePolicy < ApplicationPolicy
  def create?
    #user.present? && ((defined? record.user).nil? ? true : (record.user.nil? ? true : !(record.user == user)))
    return false unless user.present?
    return true  if (defined? record.user).nil? || record.user.nil?
    record.bookmark.user == user ? false : true
  end

  def destroy?
    create?
  end
end
