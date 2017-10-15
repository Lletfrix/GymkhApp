class ChallengesController < AdminController
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]

  # GET /challenges
  # GET /challenges.json
  def index
    @challenges = current_user.challenges
  end

  # GET /challenges/1
  # GET /challenges/1.json
  def show
  end

  # GET /challenges/new
  def new
    @challenge = Challenge.new
  end

  # GET /challenges/1/edit
  def edit
  end

  def first
    @game = Game.find_by(slug: params[:g])
    if next_challenge = @game.pending_challenges(current_user).sample
      redirect_to challenge_url(next_challenge)
    else
      redirect_to leaderboard_game_path(@game), notice: 'You\'ve finished the game!'
    end
  end

  def complete
    @challenge = Challenge.find(params[:id])
    current_user.completed_challenges << @challenge
    current_user.save

    if next_challenge = @challenge.game.pending_challenges(current_user).sample
      redirect_to challenge_url(next_challenge), notice: 'You completed a challenge!'
    else
      redirect_to leaderboard_game_path(@game), notice: 'You\'ve finished the game!'
    end
  end

  # POST /challenges
  # POST /challenges.json
  def create
    @challenge = Challenge.new(challenge_params)
    @challenge.user = current_user

    respond_to do |format|
      if @challenge.save
        format.html { redirect_to @challenge, notice: 'Challenge was successfully created.' }
        format.json { render :show, status: :created, location: @challenge }
      else
        format.html { render :new }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /challenges/1
  # PATCH/PUT /challenges/1.json
  def update
    respond_to do |format|
      if @challenge.update(challenge_params)
        format.html { redirect_to @challenge, notice: 'Challenge was successfully updated.' }
        format.json { render :show, status: :ok, location: @challenge }
      else
        format.html { render :edit }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenges/1
  # DELETE /challenges/1.json
  def destroy
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to challenges_url, notice: 'Challenge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def challenge_params
      params.require(:challenge).permit(:title, :description, :foursquare_id, :user_id)
    end
end
