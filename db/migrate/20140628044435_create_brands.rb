class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :image
      t.string :website
      t.text :address

      t.timestamps
    end
  end
end
