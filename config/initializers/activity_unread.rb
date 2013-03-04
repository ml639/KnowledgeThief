PublicActivity::Activity.module_eval do

  acts_as_readable :on => :created_at

end
