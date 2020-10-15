module UserSessionsHelper
  def logout
    session.destroy
  end

  def current_user
    @current_user = (User.find_by(username: session[:username]) if session[:name])
  end

  def current_user?
    @current_user = User.find_by(username: session[:username])
    if @current_user.nil?
      false
    else
      true
    end
  end

  def authenticate_user!
      unless current_user?
        format.html { redirect_to login_path, notice: 'Please Loged In' }
      end
  end
end
