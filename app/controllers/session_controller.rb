class SessionController < ApplicationController
  #before_action :previous_page, only: [:new]

  def new
    #@referrer = session[:return_to] = request.referer
    #byebug
    render :new
  end

  def create
    #byebug
     user = User.find_by(username: params[:username])
     if user && user.authenticate(params[:password])
       session[:user_id] = user.id
      #if session[:return_to]
      #  redirect_to session[:return_to]
      #else
        redirect_to posts_path
      #end
     else
    flash[:errors] = "Username/Password combo is invalid" #adjust new view
    redirect_to login_path
   end
  end

  def destroy
    #session.delete(:return_to)
    session.delete(:user_id)
    redirect_to login_path
  end

  private

  # def previous_page
  #   session[:return_to] ||= request.referer
  # end

end
