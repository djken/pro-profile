class ProfileController < ApplicationController
    skip_before_action :only_signed_in, only: [:index]
    def index
        
    end
end
