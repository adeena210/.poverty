#Project name: ./poverty/resources
#Description: This website contains directories containing non-profit organizations, projects, and food banks that help those suffering from period poverty. 
#One can create an account and create entries for these directories. Additionally, if you require help or would simply like to donate products, 
#you can go to a directory, and search for locations closest to you
#Filename: entries_controller.rb
#Description: The entries controller performs multiple functionalities including CRUD operations as well as the search functionality. 
#It allow handles the different views for the directory side view and the user side view.
#Last modified on: 4/20/2022
class EntriesController < ApplicationController
  
  before_action :get_user, only: %i[ show edit update destroy ]
  before_action :get_directory, only: %i[ index new create show edit update destroy ]
  before_action :set_entry, only: %i[ show edit update destroy ] 
  before_action :authenticate_user!, only: [:create, :new]

  MAX_SEARCH_RANGE = 200

  def index
      #Based on whether you're on the user view or the directory view, different sets of entries are fetched
      if params[:user_id]
        @entries = Entry.where(:user => params[:user_id]) 
      else
        if params[:search]
          #if search occurs, call dedicated search function
          @entries, error = search(params[:search], params[:filter])
          flash[:error] = error
        else
          #if no search occurs, simply fetch all records in the directory
          @entries = Entry.where(:directory => params[:directory_id])
        end
      end
  end

  def show
  end

  def new
      #entries are created in relation to its directory
      @entry = @directory.entries.build
  end

  def edit
  end

  def create
    @entry = @directory.entries.build(entry_params)
    #need to know the user to make an entry
    @entry.user = current_user
    
    respond_to do |format|
      if @entry.save
        format.html { redirect_to directory_entry_path(:id => @entry.id), notice: "Entry was successfully created." }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @entry.update(entry_params)
      puts entry_params
        #different paths depending on whether you're on the user page or the directory page
        if params[:user_id]
          format.html { redirect_to user_entries_path(:id => @entry.id), notice: "Entry was successfully updated." }
        else
          format.html { redirect_to directory_entries_path(:id => @entry.id), notice: "Entry was successfully updated." }
        end
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @entry.destroy
    respond_to do |format|
      if params[:user_id]
        #different paths depending on whether you're on the user page or the directory page
        format.html { redirect_to user_entries_url, notice: "Entry was successfully destroyed." }
      else
        format.html { redirect_to directory_entries_url, notice: "Entry was successfully destroyed." }
      end
      format.json { head :no_content }
    end
  end

  private
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Only allows a list of trusted parameters through.
    def entry_params
      params.require(:entry).permit(:name, :address_1, :address_2, :city, :state, :zipcode, :phone_number, :description, :verified, :directory_id, :search)
    end

    #gets the user associated with the entry
    def get_user
      if params[:user_id]
        @user = User.find(params[:user_id])
      else
        user = Entry.find(params[:id]).user
        @user = User.find(user.id)
      end
    end

    #gets the directory associated with the entry
    def get_directory
      if params[:directory_id]
        @directory = Directory.find(params[:directory_id])
      elsif params[:user_id]
        if params[:id]
          directory = Entry.find(params[:id]).directory
          @directory = Directory.find(directory.id)
        else
          return
        end
      end
    end

  def search(search, filter)
    if search
      #add directory's location to search request
      search = search + ", "+ @directory.location

      #if address cannot be validated 
      if Geocoder.search(search).blank?
        return Entry.where(:directory => params[:directory_id]), "Address doesn't exist."
      end

      #set search filters 
      if filter == 'all'
        range = MAX_SEARCH_RANGE
      else
        range = filter
      end

      #perform search & return results of search
      return Entry.where(:directory => params[:directory_id]).near(search, range), nil 
    end
  end
end
