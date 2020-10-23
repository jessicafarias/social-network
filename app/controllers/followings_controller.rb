class FollowingsController < ApplicationController
  include FollowingsHelper
  before_action :set_following, only: %i[show edit update destroy]

  def new
    @following = Following.new
  end

  def create
    @follow = User.find_by(id: params[:id])
    if current_user.start_to_follow(@follow)
      redirect_to(root_path, notice: 'Following')
    else
      redirect_to(root_path, notice: 'Something wrong happen')
    end
  end

  def destroy
    @following.destroy
    redirect_to(root_path, notice: 'Unfollowed.')
  end
end
