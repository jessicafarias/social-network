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
      redirect_to login_path
      flash.now.alert = 'Login failed.'
    end
  end
end
