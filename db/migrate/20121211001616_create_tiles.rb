class CreateTiles < ActiveRecord::Migration
  def change
    create_table :tiles do |t|
      t.integer :advertisement_id
      t.integer :x_location
      t.integer :y_location
	    t.decimal :cost

      t.timestamps
    end
    add_index :tiles, :advertisement_id
  end
end
