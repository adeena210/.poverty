class ProfileController < ApplicationController
    before_action :authenticate_user!
    def index
        @profile = Profile.find_by(user_id: params[:user_id])
      end
    
    def edit
        @profile = Profile.find_by user_id: current_user.id
    end
end 