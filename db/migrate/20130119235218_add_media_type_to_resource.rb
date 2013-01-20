class AddMediaTypeToResource < ActiveRecord::Migration
  def change
    add_column :resources, :add_column, :string
    add_column :resources, :, :resource,
    add_column :resources, :, :media_type,
    add_column :resources, :, :string
  end
end
