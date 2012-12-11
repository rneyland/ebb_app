class AddBoardIdToPaymentDetails < ActiveRecord::Migration
  def change
    add_column :payment_details, :board_id, :integer
  end
end
