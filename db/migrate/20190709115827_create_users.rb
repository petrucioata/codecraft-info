class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :deleted, default: false

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
