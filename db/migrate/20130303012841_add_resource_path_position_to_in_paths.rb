class AddResourcePathPositionToInPaths < ActiveRecord::Migration
  def change
  	add_column :in_paths, :resource_path_position, :integer
  end
end
