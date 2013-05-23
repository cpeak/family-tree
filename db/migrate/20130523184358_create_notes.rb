class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :person_id
      t.text :content

      t.timestamps
    end
  end
end
