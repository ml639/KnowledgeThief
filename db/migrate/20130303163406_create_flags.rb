class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.integer :item_id
      t.string :itemtype
      t.string :desc
      t.integer :reporter_id
      t.boolean :resolved
      t.integer :moderator_id
      t.string :moderator_msg
      t.string :action
      t.boolean :checked

      t.timestamps
    end
  end
end
