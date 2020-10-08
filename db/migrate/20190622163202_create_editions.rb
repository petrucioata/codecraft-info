class CreateEditions < ActiveRecord::Migration[5.2]
  def change
    create_table :editions do |t|
      t.string :name
      t.string :topic
      t.string :link
      t.text :description
      t.date :date

      t.timestamps
    end
  end
end
