class AddReadFlgToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :read_flg, :integer, null: true, default: 0
  end
end
