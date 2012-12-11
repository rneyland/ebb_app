class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
	  t.integer :user_id
	  t.string 	:name
      t.integer :height 
      t.integer :width
      t.string :timezone
      t.integer :age, default: 0
      t.timestamps
    end
	add_index :boards, :user_id
  end
end
