class Advertisement < ActiveRecord::Base
    attr_accessible  :height, :image, :image_contents, :width, :x_location, :y_location

    after_create :generate_tiles, :charge
  
    belongs_to :user
    belongs_to :board
    has_many   :tiles
    has_many   :payment_details, as: :payable

    validates :width, presence: true, numericality: {only_integer: true, greater_than: 0}
    validates :height, presence: true, numericality: {only_integer: true, greater_than: 0}
    validates :x_location, presence: true, numericality: {only_integer: true}
    validates :y_location, presence: true, numericality: {only_integer: true}
    validates :image, presence: true
    validates :board_id, presence: true
    validate  :validate_bounds

  

    def generate_tiles
            self.width.times do |i|
                self.height.times do |j|
                    tile = self.tiles.build(x_location: i + self.x_location, y_location: j + self.y_location)
                    tile.advertisement = self
                    tile.cost = 1.0
                    tile.save
                end
            end
 
    end

    def charge
        if (self.image != "fake")
            payment_detail = self.user.payment_details.build(amount: self.tiles.sum(:cost)) #conditions: ['advertisement_id = ?', self.id]))
            payment_detail.payable = self
            payment_detail.save
        end
    end

    def validate_bounds
        if  x_location != nil && (board.width <= x_location || x_location < 0)
            errors.add(:x_location, "out of bounds") 
        end
        if y_location != nil && (board.height <= y_location || y_location < 0)
            errors.add(:y_location, "out of bounds") 
        end
        if  x_location != nil && (board.width < width)
            errors.add(:x_location, "out of bounds") 
        end
        if y_location != nil && (board.height < height)
            errors.add(:y_location, "out of bounds") 
        end
        if x_location != nil && x_location + width > board.width
            errors.add(:x_location, "out of bounds")
        end
        if y_location != nil && y_location + height > board.height
            errors.add(:y_location, "out of bounds")
        end
    end
end
