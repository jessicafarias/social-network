class OpinionsController < ApplicationController
  include UserSessionsHelper
  before_action :authenticate_user!
  before_action :set_opinion, only: %i[show edit update destroy]

  def index
    @opinions = Opinion.all.order_desc
    @opinion = Opinion.new
    @whotofollow = User.who_to_follow(current_user)
  end

  def show
    case params[:list]
    when '1'
      @users = current_user.followings
      @tag = 'FOLLOWING'
    when '2'
      @users = User.fans(current_user)
      @tag = 'FOLLOWERS'
    else
      @users = User.all.where('id!=?', current_user.id)
      @tag = 'ALL USERS'
    end
  end

  def new
    @opinion = Opinion.new
    @opinions = current_user.opinions.order_desc
  end

  def edit; end

  def create
    @opinion = Opinion.new(opinion_params)
    @opinion.user_id = User.find_by(username: current_user.username.to_s).id
    respond_to do |format|
      if @opinion.save
        format.html { redirect_to new_opinion_path, notice: 'Opinion was successfully created.' }
        format.json { render :show, status: :created, location: @opinion }
      else
        format.html { render :new }
        format.json { render json: @opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @opinion.update(opinion_params)
        format.html { redirect_to new_opinion_path, notice: 'Opinion was successfully updated.' }
        format.json { render :show, status: :ok, location: @opinion }
      else
        format.html { render :edit }
        format.json { render json: @opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_opinion
    @opinion = Opinion.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def opinion_params
    params.require(:opinion).permit(:body)
  end
end
