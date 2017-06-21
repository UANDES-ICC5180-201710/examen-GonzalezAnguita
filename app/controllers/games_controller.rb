class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :can_modify
  before_action :has_staff_permission, only: [:edit, :update, :destroy]
  before_action :set_game, only: [:show, :edit, :update, :destroy, :user_purchased]

  # GET /games
  # GET /games.json
  def index
    if params[:search]
      @games = Game.search(params[:search])
      return
    end
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end
  
  def user_purchased
    @game.purchase_game(params[:user_id])
    
    purchased = @game.user_purchased?(params[:user_id])
    
    render :json => {:purchased => purchased}
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end
  
    def can_modify
      if current_user
        user = User.find(current_user.id)
        
        if user.is_staff
          @can_modify = true
          return
        end
      end
    end
  
    def has_staff_permission
      unless @can_modify
        flash[:alert] = "User is not staff"
        redirect_to games_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:title, :description, :image_url)
    end
end
