class GamesController < AdminController
  before_action :set_game, only: [:show, :edit, :update, :destroy, :share, :leaderboard]

  # GET /games
  # GET /games.json
  def index
    @games = current_user.games
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  def share
  end

  def leaderboard
    @participants = User.all.to_a
    @participants.reject! { |p| p.game_progress(@game) < 1 }
    @participants.sort! { |p| p.game_progress }
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)
    @game.user = current_user

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
    @game.challenges.each { |c| c.user = current_user }
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to share_game_url(@game) }
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
      @game = Game.find_by(id: params[:id], user: current_user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:title, :ends_at, challenges_attributes: [:id, :title, :description, :foursquare_id])
    end
end
