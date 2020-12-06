class Challenges::WinsController < ApplicationController
  before_action :set_challenge
  before_action :authenticate_user!, except: [:show]
  before_action :set_win, except: [:index, :new, :create]

  def index
    @wins = Win.where(challenge_id: params[:challenge_id]).reverse
  end

  def new
    @win = Win.new
  end

  def edit
    if current_user.id != @win.user.id
      redirect_to challenge_win_path(@win.challenge, @win), notice: 'You can\'t edit other people\'s wins.'
    end
  end

  def create
    @win = Win.new(win_params)
    @win.user = current_user
    @win.challenge = Challenge.find(params[:challenge_id]);

    respond_to do |format|
      if @win.save
        UserMailer.notify_others_of_win(@win).deliver_later
        format.html { redirect_to challenge_path(@win.challenge), notice: 'Your win has been logged.' }
      else
        format.html { render :new }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @win.update(win_params)
        format.html { redirect_to challenge_win_path(@challenge, @win), notice: 'Win was successfully updated for this challenge.' }
        format.json { render :show, status: :ok, location: @win }
      else
        format.html { render :edit }
        format.json { render json: @win.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_win
      @win = Win.find(params[:id])
    end

    def set_challenge
      @challenge = Challenge.find(params[:challenge_id])
    end

    def win_params
      params.require(:win).permit(
        :title, :description, images: []
      )
    end
end
