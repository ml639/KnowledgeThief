class CreateUserResourceViews < ActiveRecord::Migration
  def change
    create_table :user_resource_views do |t|
      t.integer :resource_id
      t.integer :user_id

      t.timestamps
    end
  end
end
