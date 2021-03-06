class SessionsController < ApplicationController
    before_action :only_signed_out, only:[:new, :create]
  
    def new
    end
  
    def create
      user_params = params.require(:user)
      @user = User.where(email: user_params[:email]).first
    #   @user = User.where(username: user_params[:username]).or(User.where(email: user_params[:username])).first
  
      if @user and @user.authenticate(user_params[:password])
        session[:auth] = @user.to_session
        redirect_to @user, success: 'You are connected successfully!'
      else
        redirect_to new_session_path, danger: 'You have entered the wrong information!'
      end
    end
  
    def destroy
      session.destroy
      redirect_to new_session_path, success: 'Your are now disconnected!'
    end
  end
  