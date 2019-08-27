class ProfilesController < ApplicationController
    before_action :set_user

    def create
        @profile = @user.profiles.create(profile_params)
        # redirect_to @post
    end

    def edit
        @user = User.find(param[current_user])
    end

    def profile_params
        params.require(:profile).permit(:phone, :profession)
    end

    def set_user
        @user = User.find(params[:user_id])
    end
end