class CreateInPaths < ActiveRecord::Migration
  def up
	   create_table :in_paths, :id => false do |t|
	    t.column :path_id, :integer
	    t.column :resource_id, :integer
	  end
  end

  def down
  	drop_table :in_paths
  end
end
