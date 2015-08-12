class SessionsController < ApplicationController
  layout "login.html"

  def new
    if signed_in?
      redirect_back_or current_user
    end
  end

  def create
    user = User.authenticate(params[:session][:username],
                             params[:session][:password])
    if user.nil?
      redirect_to(login_path, :alert => 'Invalid email/password combination.')
    else
      sign_in user
      redirect_back_or user
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end
end
