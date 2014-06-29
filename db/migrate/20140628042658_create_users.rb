class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :password_digest
      t.string :avatar
      t.string :size
      t.integer :age
      t.string :email

      t.timestamps
    end
  end
end
