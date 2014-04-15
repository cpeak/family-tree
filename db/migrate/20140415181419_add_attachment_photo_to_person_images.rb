class AddAttachmentPhotoToPersonImages < ActiveRecord::Migration
  def self.up
    change_table :person_images do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :person_images, :photo
  end
end
