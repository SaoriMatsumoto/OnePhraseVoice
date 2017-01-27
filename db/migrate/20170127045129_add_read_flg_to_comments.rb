class AddReadFlgToComments < ActiveRecord::Migration
  def change
    add_column :comments, :read_flg, :integer, null: true, default: 0
  end
end
