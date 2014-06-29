class CreateOutfits < ActiveRecord::Migration
  def change
    create_table :outfits do |t|

      t.timestamps
    end
  end
end
