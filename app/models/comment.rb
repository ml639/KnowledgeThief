class Comment < ActiveRecord::Base
  include PublicActivity::Common
  #tracked owner: ->(controller, model) { controller && controller.current_user }

  attr_accessible :content, :resource_id, :user_id
  belongs_to :user
  belongs_to :resource
  end
