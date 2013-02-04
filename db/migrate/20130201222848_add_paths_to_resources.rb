class AddPathsToResources < ActiveRecord::Migration
  def change
    add_column :resources, :path_id, :integer
  end
end
