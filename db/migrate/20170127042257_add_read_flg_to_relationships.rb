class AddReadFlgToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :read_flg, :integer, null: true, default: 0
  end
end
