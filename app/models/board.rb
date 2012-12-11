class Board < ActiveRecord::Base
	attr_accessible :name, :height, :width, :timezone, :age
	
	belongs_to :user
	
	
	has_many :advertisements
	has_many :tiles, through: :advertisements
	has_many :payment_details, as: :payable


	validates :name, presence: true
	validates :height, presence: true, numericality: {only_integer: true, greater_than: 0}
	validates :width, presence: true, numericality: {only_integer: true, greater_than: 0}
	validates :timezone, presence: true
	validates :age, presence: true
	validates_inclusion_of :timezone, :in => ActiveSupport::TimeZone.zones_map { |m| m.name }


	 private 
	
	def self.save_all(board)
		begin
			transaction do 
				board.save!
				
				payment_detail = board.payment_details.build
				payment_detail.user_id = board.user.id
				payment_detail.amount = board.width * board.height
				payment_detail.save!
				advertisement = board.advertisements.build(width: 1, height: 1, x_location: 0, y_location: 0, image: "fake", image_contents: "fake")
				advertisement.user_id = board.user_id
				advertisement.save!
				payment_detail2 = advertisement.payment_details.build
				payment_detail2.user_id = advertisement.user.id
				payment_detail2.amount = advertisement.width * advertisement.height
				payment_detail2.save!
			end
		rescue 
			# puts board.errors.add(:name, board.errors.full_messages.each do |msg| msg end)
		end
	end 


end
