class FollowingsController < ApplicationController
  include UserSessionsHelper
  before_action :set_following, only: %i[show edit update destroy]

  # GET /followings
  # GET /followings.json
  def index
    @followings = Following.all
  end

  # GET /followings/1
  # GET /followings/1.json
  def show; end

  # GET /followings/new
  def new
    @following = Following.new
  end

  # GET /followings/1/edit
  def edit; end

  # POST /followings
  # POST /followings.json
  def create
    @follow = User.find_by(id: params[:id])
    respond_to do |format|
      if current_user.start_to_follow(@follow)
        format.html { redirect_to root_path, notice: 'Following was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @following.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /followings/1
  # PATCH/PUT /followings/1.json
  def update
    respond_to do |format|
      if @following.update(following_params)
        format.html { redirect_to @following, notice: 'Following was successfully updated.' }
        format.json { render :show, status: :ok, location: @following }
      else
        format.html { render :edit }
        format.json { render json: @following.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /followings/1
  # DELETE /followings/1.json
  def destroy
    @following.destroy
    respond_to do |format|
      format.html { redirect_to followings_url, notice: 'Following was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_following
    @following = Following.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def following_params
    params.require(:following).permit(:user_id)
  end
end
