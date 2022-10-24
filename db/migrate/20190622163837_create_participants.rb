class CreateParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :participants do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :link
      t.references :position, foreign_key: true
      t.boolean :deleted, default: false

      t.timestamps
    end
    add_index :participants, :username, unique: true
  end
end
