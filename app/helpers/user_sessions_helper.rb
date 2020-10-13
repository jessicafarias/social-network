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
end
