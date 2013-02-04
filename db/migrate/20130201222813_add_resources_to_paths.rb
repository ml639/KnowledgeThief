class AddResourcesToPaths < ActiveRecord::Migration
  def change
    add_column :paths, :resource_id, :integer
  end
end
