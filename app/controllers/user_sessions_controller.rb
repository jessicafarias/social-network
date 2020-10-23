class UserSessionsController < ApplicationController
  include FollowingsHelper
  def new; end

  def create
    user = User.find_by(username: params[:username])
    if user.nil?
      flash.now.alert = 'Login failed'
      render action: :new
    else
      session[:name] = user.fullname
      session[:username] = user.username
      redirect_to(:users, notice: 'Sign In Succesful.')
    end
  end

  def destroy
    logout
    redirect_to(:users, alert: 'Logged out!')
  end
end
