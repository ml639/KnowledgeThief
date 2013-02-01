class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
