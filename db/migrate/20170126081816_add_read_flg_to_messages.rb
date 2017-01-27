class AddReadFlgToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :read_flg, :integer, null: true, default: 0
  end
end
