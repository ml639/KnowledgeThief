class AddFbVariablesToUser < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string
    add_column :users, :nickname, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :image, :string
    add_column :users, :location, :string
    add_column :users, :birthday, :date
    add_column :users, :hometown_name, :string
    add_column :users, :bio, :string
    add_column :users, :gender, :string    
  end
end
