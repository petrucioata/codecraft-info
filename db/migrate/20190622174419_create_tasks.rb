class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :author
      t.text :description
      t.references :edition, foreign_key: true
      t.boolean :deleted, default: false

      t.timestamps
    end
    add_index :tasks, :name, unique: true
  end
end
