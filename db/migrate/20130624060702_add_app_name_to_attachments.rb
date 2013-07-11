class AddAppNameToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :app_name, :string
  end
end
