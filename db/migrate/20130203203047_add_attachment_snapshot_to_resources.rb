class AddAttachmentSnapshotToResources < ActiveRecord::Migration
  def self.up
    change_table :resources do |t|
      t.attachment :snapshot
    end
  end

  def self.down
    drop_attached_file :resources, :snapshot
  end
end
