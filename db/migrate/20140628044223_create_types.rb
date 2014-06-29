class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :name
      t.integer :warmth
      t.integer :category_id

      t.timestamps
    end
  end
end
