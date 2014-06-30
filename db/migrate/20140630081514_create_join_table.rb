class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :items, :outfits do |t|
      t.index [:item_id, :outfit_id]
      t.index [:outfit_id, :item_id]
    end
  end
end
