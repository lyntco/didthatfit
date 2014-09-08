class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :shoe_size, :integer
    add_column :users, :bust, :integer
    add_column :users, :hips, :integer
    add_column :users, :waist, :integer
    add_column :users, :height, :integer
  end
end
