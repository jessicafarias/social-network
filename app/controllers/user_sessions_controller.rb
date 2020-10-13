class UserSessionsController < ApplicationController
  include UserSessionsHelper
  def new; end

  def create
    user = User.find_by(username: params[:username])
    if user.nil?
      flash.now.alert = 'Login failed.'
      render action: :new
    else
      session[:name] = user.name
      session[:username] = user.username
      redirect_to(:users, notice: 'Sign In Succesful.')
    end
  end

  def destroy
    logout
    redirect_to(:users, notice: 'Logged out!')
  end
end
