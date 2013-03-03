class InPath < ActiveRecord::Base
	belongs_to :path
	belongs_to :resource
	scope :this_path, lambda { |path| where("path_id = ?", path) }
	scope :resource_belongs_to, lambda { |resource| where("resource_id = ?", resource) }

	attr_accessible :path, :resource, :resource_path_position
end