class DropTableFavorites < ActiveRecord::Migration
  def change
    drop_table :favorites
  end
end
