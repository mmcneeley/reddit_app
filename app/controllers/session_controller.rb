class SessionController < ApplicationController

  def new
    render :new
  end

  def create
     user = User.find_by(username: params[:username])
     if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect_to user
     else
    flash[:errors] = "Username/Password combo is invalid" #adjust new view
     redirect_to login_path
   end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end

end
