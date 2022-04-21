#Project name: ./poverty/resources
#Description: This website contains directories containing non-profit organizations, projects, and food banks that help those suffering from period poverty. 
#One can create an account and create entries for these directories. Additionally, if you require help or would simply like to donate products, 
#you can go to a directory, and search for locations closest to you
#Filename: directories_controller.rb
#Description: The directories controller performs multiple functionalities related to CRUD operations.
#Last modified on: 4/20/2022


class DirectoriesController < ApplicationController
  before_action :set_directory, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @directories = Directory.all
  end

  #showing a directory is equivalent to viewing the entries within the directory
  def show
    redirect_to directory_entries_path(params[:id])
  end

  def new
    @directory = Directory.new
  end

  def edit
  end

  def create
    @directory = Directory.new(directory_params)

    respond_to do |format|
      if @directory.save
        format.html { redirect_to directory_url(@directory), notice: "Directory was successfully created." }
        format.json { render :show, status: :created, location: @directory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @directory.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @directory.update(directory_params)
        format.html { redirect_to directory_url(@directory), notice: "Directory was successfully updated." }
        format.json { render :show, status: :ok, location: @directory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @directory.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @directory.destroy

    respond_to do |format|
      format.html { redirect_to directories_url, notice: "Directory was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_directory
      @directory = Directory.find(params[:id])
    end

    # Only allows a list of trusted parameters through.
    def directory_params
      params.require(:directory).permit(:location)
    end
end
