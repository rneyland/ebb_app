class PaymentDetail < ActiveRecord::Base
  attr_accessible :amount, :payment_type
  belongs_to :board
  belongs_to :user

  
end
