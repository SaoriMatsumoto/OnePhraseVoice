class CreateVoices < ActiveRecord::Migration
  def change
    create_table :voices do |t|
      t.references :user, index: true, foreign_key: true
      t.binary :file
      t.text :description

      t.timestamps null: false
      t.index [:user_id, :created_at]
    end
  end
end
