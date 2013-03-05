class AddUserIdToPath < ActiveRecord::Migration
  def change
  	add_column :paths, :user_id, :string
  end
end
