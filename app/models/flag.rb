class Flag < ActiveRecord::Base
  attr_accessible :action, :checked, :desc, :item_id, :itemtype, :moderator_id, :moderator_msg, :reporter_id, :resolved
end
