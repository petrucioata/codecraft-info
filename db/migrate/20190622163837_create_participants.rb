class CreateParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :participants do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :link
      t.references :position, foreign_key: true

      t.timestamps
    end
  end
end
