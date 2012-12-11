class AddParamsToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :name, :string
    add_column :boards, :height, :int
    add_column :boards, :width, :int
  end
end
