class AddMediaTypeToResource < ActiveRecord::Migration
  def change
    add_column :resources, :media_type, :string
  end
end
