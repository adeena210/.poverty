class NjsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_nj, only: %i[ show edit update destroy ]

  # GET /njs or /njs.json
  def index
    @njs = Nj.all
  end

  # GET /njs/1 or /njs/1.json
  def show
  end

  # GET /njs/new
  def new
    @nj = Nj.new
  end

  # GET /njs/1/edit
  def edit
  end

  # POST /njs or /njs.json
  def create
    @nj = Nj.new(nj_params)

    respond_to do |format|
      if @nj.save
        format.html { redirect_to nj_url(@nj), notice: "Nj was successfully created." }
        format.json { render :show, status: :created, location: @nj }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @nj.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /njs/1 or /njs/1.json
  def update
    respond_to do |format|
      if @nj.update(nj_params)
        format.html { redirect_to nj_url(@nj), notice: "Nj was successfully updated." }
        format.json { render :show, status: :ok, location: @nj }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @nj.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /njs/1 or /njs/1.json
  def destroy
    @nj.destroy

    respond_to do |format|
      format.html { redirect_to njs_url, notice: "Nj was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nj
      @nj = Nj.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def nj_params
      params.require(:nj).permit(:name, :address, :description, :verified)
    end
end
