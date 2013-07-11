class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.attachment :attach
      t.timestamps
    end
  end
end
