class CreateEditions < ActiveRecord::Migration[5.2]
  def change
    create_table :editions do |t|
      t.string :name, unique: true
      t.string :topic
      t.string :link, unique: true
      t.text :description
      t.date :date

      t.timestamps
    end
  end
end
