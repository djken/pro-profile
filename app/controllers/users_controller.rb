class UsersController < ApplicationController 
    skip_before_action :only_signed_in, only: [:new, :create, :confirm, :show]
    before_action :only_signed_out, only:[:new, :create, :confirm]

    def new 
        @user = User.new
    end

    def index
        @users = User.all
        # @user = User.find_by(params[:id])
        # render json:@user.to_json
    end
    def show
        @user = User.find(params[:id])
    end

    def create
        user_params = params.require(:user).permit(:username, :firstname, :lastname, :email, :password, :password_confirmation, :image, :phone)
        @user = User.new(user_params)
        # render json:@user.to_json
        if @user.valid?
            @user.save
            @user_id = User.find(@user.id)
            Profile.create(user_id: @user_id.id)
            redirect_to login_path, success: "Your account has been created, you should receive an email to confirm your account."
        else
            render 'new'
        end
    end

    def edit
        @user = current_user
    end

    def update
        @user = current_user
        user_params = params.require(:user).permit(:fullname, :profession, :email, :phone, :description, :password)
        if @user.update(user_params)
            redirect_to profile_url, success: "Your account has been updated!"
        else
            render :edit
        end
    end
end
