class AddOriginalIdToVoices < ActiveRecord::Migration
  def change
    add_column :voices, :original_id, :integer
  end
end
