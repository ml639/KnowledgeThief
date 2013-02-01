# This migration comes from engage (originally 20120220142933)
class CreateEngageComments < ActiveRecord::Migration
  def change
    create_table :engage_comments do |t|
      t.integer :user_id, :null => false
      t.integer :topic_id, :null => false
      t.text :body, :null => false

      t.timestamps
    end
  end
end
