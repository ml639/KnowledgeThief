class Path < ActiveRecord::Base

  attr_accessible :content, :name, :user_id
  belongs_to :user
  has_many :in_paths
  has_many :resources, :through => :in_paths
  scope :user_paths, lambda { |user| where("user_id = ?", user) }

end
