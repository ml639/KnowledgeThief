class Flag < ActiveRecord::Base
  attr_accessible :action, :checked, :desc, :item_id, :itemtype, :moderator_id, :moderator_msg, :reporter_id, :resolved
  
  def create_flag(type, typeid, reporterid, desc)
  	self.itemtype = type
  	self.item_id = typeid
  	self.desc = desc
  	self.reporter_id = reporterid
  	self.checked = False
  	self.resolved = False
  end

end
