class AddYoutubeIdColumnToResources < ActiveRecord::Migration
  def change
    add_column :resources, :youtubeID, :string
  end
end
