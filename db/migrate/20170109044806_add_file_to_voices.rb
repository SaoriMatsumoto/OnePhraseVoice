class AddFileToVoices < ActiveRecord::Migration
  def change
    add_column :voices, :file, :string
  end
end
