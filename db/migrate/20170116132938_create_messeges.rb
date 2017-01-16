class CreateMesseges < ActiveRecord::Migration
  def change
    create_table :messeges do |t|
      t.references :user, index: true, foreign_key: true
      t.text :message
      t.integer :post_user_id

      t.timestamps null: false
    end
  end
end
