class AddTableNameToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :table_name, :string
    add_column :attachments, :table_id, :integer
  end
end
