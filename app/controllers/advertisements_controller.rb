class AdvertisementsController < ApplicationController
  #before_filter :signed_in_user,  only: [:show, :index, :img, :create]
  before_filter :load_user



  def show
    @advertisement = @board.advertisements.find(params[:id])
  	
  end

  def new
    
  	@advertisement = Advertisement.new

  end

  def create

         @advertisement = @board.advertisements.build(params[:advertisement])
           begin 
            
            @advertisement.image = @advertisement.image_contents.original_filename
            @advertisement.image_contents = @advertisement.image_contents.read

           rescue
            @advertisement.image_contents = nil
            @advertisement.image = nil
           end 
                if Advertisement.save_all(@advertisement, current_user)
                  flash[:success] = "Advertisement created"
                  redirect_to board_advertisement_path(@advertisement.board_id, @advertisement.id)
                else
                  render 'new'
                end
            

  end

  def index 
    @advertisement = Advertisement.all
  end

  def load_user
    @board = Board.find(params[:board_id])
  end

  def img 
      @advertisement = Advertisement.find(params[:id])
      send_data @advertisement.image_contents, filename: @advertisement.image, disposition: "inline"

  end



end
