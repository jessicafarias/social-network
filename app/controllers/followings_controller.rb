class FollowingsController < ApplicationController
  include UserSessionsHelper
  before_action :set_following, only: %i[show edit update destroy]

  def new
    @following = Following.new
  end

  def create
    @follow = User.find_by(id: params[:id])
    respond_to do |format|
      if current_user.start_to_follow(@follow)
        format.html { redirect_to root_path, notice: 'Following' }
      else
        format.html { render :new }
        format.json { render json: @following.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @following.destroy
    respond_to do |format|
      format.html { redirect_to root_path, alert: 'Unfollowed.' }
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
