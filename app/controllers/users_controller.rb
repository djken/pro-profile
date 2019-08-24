class UsersController < ApplicationController 
    skip_before_action :only_signed_in, only: [:new, :create, :confirm]
    before_action :only_signed_out, only:[:new, :create, :confirm]

    def new 
        @user = User.new
    end

    def create
        user_params = params.require(:user).permit(:fullname, :profession, :email, :phone, :description, :password, :password_confirmation)
        @user = User.new(user_params)

        if @user.valid?
            @user.save
            redirect_to login_path, success: "Your account has been created, you should receive an email to confirm your account."
        else 
            render 'new'
        end
    end

    def confirm
        @user = User.find(params[:id])

        if @user.confirmation_token == params[:token]
            # @user.update_attributes(confirmed: true, confirmation_token: nil)
            # @user.save(validate: false)
            session[:auth] = @user.to_session
            redirect_to groups_path, success: 'Your account has been confirmed!'
        else
            redirect_to new_user_path, danger: 'This token is not valid!'
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
