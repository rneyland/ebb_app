class Board < ActiveRecord::Base
	attr_accessible :name, :height, :width, :timezone

	after_create :create_fake_ad, :create_payment
	
	belongs_to :user
	has_many   :advertisements
	has_many   :tiles, through: :advertisements
	has_one    :payment_detail, as: :payable

	validates :name, presence: true
	validates :height, presence: true, numericality: {only_integer: true, greater_than: 0}
	validates :width, presence: true, numericality: {only_integer: true, greater_than: 0}
	validates :timezone, presence: true
	
	validates_inclusion_of :timezone, :in => ActiveSupport::TimeZone.zones_map { |m| m.name }

	def create_fake_ad 
		advertisement = self.advertisements.build(width: self.width, height: self.height, x_location: 0, y_location: 0, image: "fake", image_contents: "fake")
		advertisement.user = self.user
		advertisement.save
	end

	def create_payment
		payment_detail = self.user.payment_details.build(amount: width * height * 1)
		payment_detail.payable = self
		payment_detail.save
	end

	def age 
		self.advertisements.each do |ad|
			ad.charge
			ad.tiles.each do |tile|
				tile.cost = ((tile.cost) / 2) 
				tile.save()
			end
		end
	end
end
