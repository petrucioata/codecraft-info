class CreateEditions < ActiveRecord::Migration[5.2]
  def change
    create_table :editions do |t|
      t.string :name
      t.string :topic
      t.string :link
      t.text :description
      t.date :date
      t.boolean :deleted, default: false

      t.timestamps
    end
    add_index :editions, :name, unique: true
    add_index :editions, :link, unique: true
  end
end
