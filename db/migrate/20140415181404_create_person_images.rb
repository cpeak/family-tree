class CreatePersonImages < ActiveRecord::Migration
  def change
    create_table :person_images do |t|
      t.string :caption
      t.integer :person_id

      t.timestamps
    end
  end
end
