class ProfileController < ApplicationController
    def index
        @user = User.(current_user.id)
    end

    
end 