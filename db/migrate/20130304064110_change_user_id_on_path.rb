class ChangeUserIdOnPath < ActiveRecord::Migration
  def up
  	remove_column :paths, :user_id 
  	add_column(:paths, :user_id, :integer)
  end

  def down
  	remove_column :paths, :user_id 
  	add_column(:paths, :user_id, :string)
  end
end
