class Tile < ActiveRecord::Base
  attr_accessible :x_location, :y_location


  
  belongs_to :advertisement

  has_one :board, through: :advertisement
  validates :x_location, presence: true, numericality: { only_integer: true }
  validates :y_location, presence: true, numericality: { only_integer: true }
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0.0 }

  #validates :cost, presence: true, numericality: {greater_than: 0}
  validate :check_tile_bounds

  # def set_cost 
  #     self.cost = 1.0
  #     self.save
  # end
  
  private

  	def check_tile_bounds
      if x_location != nil &&(x_location >= board.width)
        errors.add(:x_location, "out of bounds") 
      end
      if y_location != nil &&(y_location >= board.height)
        errors.add(:y_location, "out of bounds") 
      end
      if x_location != nil &&(x_location < advertisement.x_location)
        errors.add(:x_location, "out of bounds") 
      end
      if  y_location != nil &&(y_location < advertisement.y_location)
        errors.add(:y_location, "out of bounds") 
      end
      if  x_location != nil && x_location >= (advertisement.x_location+advertisement.width)
        errors.add(:x_location, "out of bounds") 
      end
     if y_location != nil && y_location >= (advertisement.y_location+advertisement.height)
        errors.add(:y_location, "out of bounds") 
      end
    end
end
