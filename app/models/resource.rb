class Resource < ActiveRecord::Base
  attr_accessible :title, :description, :link, :tag_list
  acts_as_taggable
  # acts_as_votable
end
