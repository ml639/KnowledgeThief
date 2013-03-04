class Path < ActiveRecord::Base

  attr_accessible :content, :name
  belongs_to :user
  has_many :in_paths
  has_many :resources, :through => :in_paths
  scope :user_paths, lambda { |user| where("id = ?", user) }

end
