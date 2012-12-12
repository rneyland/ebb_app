class PaymentDetail < ActiveRecord::Base
  attr_accessible :amount
 
  belongs_to :user
  belongs_to :payable, polymorphic: true

  validates :amount, presence: true, numericality: true

  #   def user=(payable)
  #   	user = payable
  # end
end
