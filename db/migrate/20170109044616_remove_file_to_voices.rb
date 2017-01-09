class RemoveFileToVoices < ActiveRecord::Migration
  def change
    remove_column :voices, :file, :string
  end
end
