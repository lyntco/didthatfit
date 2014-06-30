class RemoveFriendsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :friend_id, :integer
  end
end
