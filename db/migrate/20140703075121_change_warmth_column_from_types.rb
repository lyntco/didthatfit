class ChangeWarmthColumnFromTypes < ActiveRecord::Migration
  def change
    change_column :types, :warmth, :decimal
  end
end
