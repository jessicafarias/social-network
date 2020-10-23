module FollowingsHelper
  private

  def set_following
    @following = Following.find(params[:id])
  end

  def following_params
    params.require(:following).permit(:user_id)
  end
end
