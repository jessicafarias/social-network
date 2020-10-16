class OpinionsController < ApplicationController
  include UserSessionsHelper
  before_action :authenticate_user!
  before_action :set_opinion, only: %i[show edit update destroy]

  def index
    @opinions = Opinion.all
    @opinion = Opinion.new
    @users = User.who_to_follow(current_user)
  end

  def show; end

  def new
    @opinion = Opinion.new
    @opinions = current_user.opinions
  end

  def edit; end

  def create
    @opinion = Opinion.new(opinion_params)
    @opinion.user_id = User.find_by(username: current_user.username.to_s).id
    respond_to do |format|
      if @opinion.save
        format.html { redirect_to @opinion, notice: 'Opinion was successfully created.' }
        format.json { render :show, status: :created, location: @opinion }
      else
        format.html { render :new }
        format.json { render json: @opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opinions/1
  # PATCH/PUT /opinions/1.json
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

  # DELETE /opinions/1
  # DELETE /opinions/1.json
  def destroy
    @opinion.destroy
    respond_to do |format|
      format.html { redirect_to opinions_url, notice: 'Opinion was successfully destroyed.' }
      format.json { head :no_content }
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
