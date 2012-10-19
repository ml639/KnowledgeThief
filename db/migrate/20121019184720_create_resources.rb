class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.text :link
      t.string :title
      t.text :description
      t.integer :user_id
      t.timestamps
    end
  end
end
