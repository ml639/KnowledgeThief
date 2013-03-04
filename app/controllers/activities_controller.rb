class ActivitiesController < ApplicationController
  def index
    current_user ||= User.new
    @activities = PublicActivity::Activity.where(recipient_id: current_user.resource_ids).order("created_at desc")
    #.where(owner_id: current_user.friend_ids, owner_type: "User")
  end
end
