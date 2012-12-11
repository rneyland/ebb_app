class BoardsController < ApplicationController
  	def new
  		  @board = Board.new
  	end

  	def create
    
  		  
          @board = current_user.boards.build(params[:board])
          
          if Board.save_all(@board) 
            flash[:success] = "Board created"             
            redirect_to @board
          else
            render 'new'
          end
  	end

  	def show
  		  @board = Board.find(params[:id])
        render layout: "show_boards"
  	end

  	def index
  		  @boards = Board.all
  	end

    # def age
    #   1.increment!(:age)
    #   save!
    # end

    # def Board:age
    #     @board = Board.find(params[:id])
    #     @board.age
    # end


end
