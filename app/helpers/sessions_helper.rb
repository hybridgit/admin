module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def current_user?(user)
    user == current_user
  end

  def authenticate
    deny_access unless signed_in?
  end

  def authorize(controller, action)
    if (self.current_user.username.downcase != "admin" and !has_roles(["Administrator"]))
      @current_user = self.current_user
      @permissions = []
      @current_user.roles.each do |r|
        r.permissions.each do |p|
          @permissions << p if p.controller == controller and p.action == action
        end
      end
      redirect_to(user_path(@current_user), :alert => 'You do not have permission to access this page.') if @permissions.count <= 0
    end
  end

  def has_roles(roles_to_check)
    unless @current_user.nil?
      return @current_user.roles.where(:name => roles_to_check).count > 0
    else
      return false
    end
  end

  def deny_access
    store_location
    redirect_to login_path, :notice => "Please sign in to access this page."
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def clear_return_to
    session[:return_to] = nil
  end

  private

  def user_from_remember_token
    User.authenticate_with_salt(*remember_token)
  end

  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end

end
