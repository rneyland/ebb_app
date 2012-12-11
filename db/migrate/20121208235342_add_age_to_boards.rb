class AddAgeToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :age, :integer, default: 0
  end
end
