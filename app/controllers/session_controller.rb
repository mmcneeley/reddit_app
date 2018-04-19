class SessionController < ApplicationController

  def new
    session[:return_to] = request.referer
    render :new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to session[:return_to] || posts_path
    else
      flash[:errors] = "Username/Password combo is invalid" #adjust new view
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:return_to)
    session.delete(:user_id)
    redirect_to login_path
  end

end
