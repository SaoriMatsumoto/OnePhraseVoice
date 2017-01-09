class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :location
      t.string :profile
      t.string :birthday

      t.timestamps null: false
      
      t.index :email, unique: true
    end
  end
end
