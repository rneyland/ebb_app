class AdvertisementsController < ApplicationController
  #before_filter :signed_in_user,  only: [:show, :index, :img, :create]
  before_filter :load_user



  def show
    @advertisement = Advertisement.find(params[:id])
  	
  end

  def new
    
  	@advertisement = Advertisement.new

  end

  def create

         @advertisement = @board.advertisements.build(params[:advertisement])
           begin 
            
            @advertisement.image = @advertisement.image_contents.original_filename
            @advertisement.image_contents = @advertisement.image_contents.read
            @advertisement.user_id = current_user.id
           rescue
            @advertisement.image_contents = nil
            @advertisement.image = nil
           end 
           # if  @advertisement.save! 
           #    @payment_detail = @advertisement.payment_details.build
           #    @payment_detail.user_id = current_user.id
           #    @payment_detail.save!
           # end
                if Advertisement.save_all(@advertisement, current_user)
                  flash[:success] = "Advertisement created"
                 
                  redirect_to board_advertisement_path(@board, @advertisement)
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
