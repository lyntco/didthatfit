class ChangeFbinstagramColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :oauth_token
    remove_column :users, :oauth_expires_at
    add_column :users, :instagram_id, :string
  end
end
