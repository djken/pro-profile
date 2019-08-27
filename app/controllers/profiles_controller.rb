class ProfilesController < ApplicationController
    before_action :set_profile

    def update
        if @profile.update(profile_params)
            redirect_to user_path(@profile.user), notice: 'Your Profile has been updated!'
        else
            render 'edit'
        end
    end

    def edit

    end

    def profile_params
        params.require(:profile).permit(:phone, :profession, :description)
    end

    def set_profile
        @profile = Profile.find(params[:id])
    end
end