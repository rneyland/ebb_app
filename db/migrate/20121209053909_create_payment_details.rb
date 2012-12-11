class CreatePaymentDetails < ActiveRecord::Migration
  def change
    create_table :payment_details do |t|
      t.integer :user_id
      t.decimal :amount
      t.string :payment_type

      t.timestamps
    end
    add_index :payment_details, :user_id
  end
end
