class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user, index: true, foreign_key: true
      t.references :voice, index: true, foreign_key: true

      t.timestamps null: false
      t.index [:user_id, :voice_id], unique: true
    end
  end
end