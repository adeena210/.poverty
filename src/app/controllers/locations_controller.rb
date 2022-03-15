
class LocationsController < ApplicationController

    skip_before_action :authenticate_user!

    def nj; end
end