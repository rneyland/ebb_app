class AdvertisementsController < ApplicationController
  #before_filter :signed_in_user,  only: [:show, :index, :img, :create]

    def new
        @advertisement = Advertisement.new
    end

    def create
        @board = Board.find(params[:board_id])
        @advertisement = @board.advertisements.build(params[:advertisement])
        begin 
            @advertisement.image = @advertisement.image_contents.original_filename
            @advertisement.image_contents = @advertisement.image_contents.read
            @advertisement.user_id = current_user.id
        rescue
            @advertisement.image_contents = nil
            @advertisement.image = nil
        end 
        
        if @advertisement.save
            flash[:success] = "Advertisement created by #{@advertisement.user.name}"
            redirect_to @board
        else
            render 'new'
        end     
    end

    def display
        @advertisement = Advertisement.find(params[:id])
        send_data @advertisement.image_contents, filename: @advertisement.image, disposition: "inline"
    end
end
