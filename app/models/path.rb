class Path < ActiveRecord::Base
  attr_accessible :content, :name
  has_many :resources
end
