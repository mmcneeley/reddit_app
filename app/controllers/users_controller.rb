class UsersController < ApplicationController
  before_action :get_user, only:[:show,:edit,:update]
  before_action :require_login
  skip_before_action :require_login, only:[:new, :create]


    def index
      @users = User.all
    end

    def show
    end

    def new
      @user = User.new()
    end

    def create
      @user = User.create(user_params)
      if @user.valid?
        flash[:success] = "You have signed up for Roddit!"
        session[:user_id] = @user.id
        redirect_to @user
      else
        #byebug
        flash[:errors] = @user.errors.full_messages
        redirect_to new_user_path
      end
    end

    def edit
    end

    def update
      @user.update(user_params)
      redirect_to @user
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to users_path
    end

    private

    def get_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def require_login
      return head(:forbidden) unless session.include? :user_id
    end

end
