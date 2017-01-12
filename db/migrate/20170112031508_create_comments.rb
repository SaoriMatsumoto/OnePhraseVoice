class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :voice, index: true, foreign_key: true
      
      t.text :content
      t.integer :read_flg

      t.timestamps null: false
      t.index [:user_id, :voice_id]
    end
  end
end
