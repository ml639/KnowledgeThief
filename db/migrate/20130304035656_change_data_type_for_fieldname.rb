class ChangeDataTypeForFieldname < ActiveRecord::Migration
  def up
    change_column :read_marks, :readable_type, :text
  end
end
