class Advertisement < ActiveRecord::Base
  attr_accessible  :height, :image, :image_contents, :width, :x_location, :y_location

  belongs_to :user
  belongs_to :board
  has_many :tiles
  has_many :payment_details
  validates :width, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :height, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :x_location, presence: true, numericality: {only_integer: true}
  validates :y_location, presence: true, numericality: {only_integer: true}
  validates :image, presence: true

  validates :board_id, presence: true
  validate :check_advertisement_bounds

  private
    def check_advertisement_bounds
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

  def self.save_all(advertisement, current_user)
    begin
      transaction do 
        advertisement.user_id = current_user.id
        advertisement.save!
        payment_detail = current_user.payment_details.build
        payment_detail.board_id = advertisement.board_id
        payment_detail.save!
        x = advertisement.width 
        y = advertisement.height
               x.times do |i|
                  
                  y.times do |j|
                    tile = advertisement.tiles.build
                    tile.board_id = advertisement.board_id
                    tile.x_location = i + advertisement.x_location
                    tile.y_location = j + advertisement.y_location
                    tile.save!
                  end

                end 

      end
    rescue 

    end
  end

end
