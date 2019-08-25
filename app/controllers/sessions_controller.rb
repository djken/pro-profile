class SessionsController < ApplicationController
    skip_before_action :only_signed_in, only: [:new, :create, :index]
    before_action :only_signed_out, only:[:new, :create]
  
    def new
    end
  
    def create
      user_params = params.require(:user)
      @user = User.where(email: user_params[:email]).first
  
      if @user and @user.authenticate(user_params[:password])
        session[:auth] = @user.to_session
        redirect_to users_path, success: 'You are connected successfully!'
      else
        redirect_to new_session_path, danger: 'You have entered the wrong information!'
      end
    end
  
    def destroy
      session.destroy
      redirect_to new_session_path, success: 'Your are now disconnected!'
    end
  end
  