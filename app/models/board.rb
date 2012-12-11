class Board < ActiveRecord::Base
	attr_accessible :name, :height, :width, :timezone, :age
	
	belongs_to :user
	belongs_to :payment_detail
	
	has_many :advertisements
	has_many :tiles


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
				payment_detail = board.user.payment_details.build
				payment_detail.amount = board.width * board.height
				payment_detail.board_id = board.id
				payment_detail.save!
				advertisement = board.advertisements.build(width: 1, height: 1, x_location: 0, y_location: 0, image: "fake", image_contents: "fake")
				advertisement.user_id = board.user_id
				advertisement.save!
			end
		rescue 
		end
	end 


end
