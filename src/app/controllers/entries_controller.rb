class EntriesController < ApplicationController
  
  before_action :get_user, only: %i[ show edit update destroy ]
  before_action :get_directory, only: %i[ index new create show edit update destroy ]
  before_action :set_entry, only: %i[ show edit update destroy ] 
  before_action :authenticate_user!, only: [:create, :new]

  # GET /entries or /entries.json
  def index
      if params[:user_id]
        @entries = Entry.where(:user => params[:user_id])
      else
        @entries = Entry.where(:directory => params[:directory_id])
      end

      # puts current_page
  end

  # GET /entries/1 or /entries/1.json
  def show
  end

  # GET /entries/new
  def new
      # @entry = Entry.new(:user_id => current_user, :directory_id => params[:directory_id])
      @entry = @directory.entries.build
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries or /entries.json
  def create
  
    @entry = @directory.entries.build(entry_params)
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

  # PATCH/PUT /entries/1 or /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
      puts entry_params
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

  # DELETE /entries/1 or /entries/1.json
  def destroy
    @entry.destroy

    respond_to do |format|
      if params[:user_id]
        format.html { redirect_to user_entries_url, notice: "Entry was successfully destroyed." }
      else
        format.html { redirect_to directory_entries_url, notice: "Entry was successfully destroyed." }
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def entry_params
      params.require(:entry).permit(:name, :address, :phone_number, :description, :verified, :directory_id)
    end

    def get_user
      if params[:user_id]
        @user = User.find(params[:user_id])
      else
        user = Entry.find(params[:id]).user
        @user = User.find(user.id)
      end
    end

    def get_directory
      if params[:directory_id]
        @directory = Directory.find(params[:directory_id])
      elsif params[:user_id]
          return
      else
        directory = Entry.find(params[:id]).directory
        @directory = Directory.find(directory.id)
      end
    end
end
