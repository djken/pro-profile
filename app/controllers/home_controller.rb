class HomeController < ApplicationController
    # skip_before_action :only_signed_in, only: [:index, :show]
    def index
        @users = User.all
    end
end