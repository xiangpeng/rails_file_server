class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :app_name
      t.string :access_token
      t.timestamps
    end
  end
end
