class UserSearch < ActiveRecord::Base
  attr_accessible :query, :user_id
  belongs_to :user
end
