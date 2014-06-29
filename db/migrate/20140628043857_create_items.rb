class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :type_id
      t.integer :brand_id
      t.string :size
      t.string :fit

      t.timestamps
    end
  end
end
