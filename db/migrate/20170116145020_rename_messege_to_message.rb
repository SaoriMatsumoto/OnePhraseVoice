class RenameMessegeToMessage < ActiveRecord::Migration
  def change
    rename_table :messeges, :messages
  end
end
