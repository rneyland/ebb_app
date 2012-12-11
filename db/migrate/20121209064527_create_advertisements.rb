class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.integer :user_id
      t.integer :board_id
      t.integer :height
      t.integer :width
      t.integer :x_location
      t.integer :y_location
      t.string :image
      t.binary :image_contents

      t.timestamps
    end
     add_index :advertisements, :user_id
     add_index :advertisements, :board_id
  end
end
