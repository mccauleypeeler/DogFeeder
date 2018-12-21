class CaresController < ApplicationController
  before_action :set_care, only: [:show, :edit, :update, :destroy]

  # GET /cares
  # GET /cares.json
  def index
    @cares = Care.all
  end

  # GET /cares/1
  # GET /cares/1.json
  def show
  end

  # GET /cares/new
  def new
    @care = Care.new
  end

  # GET /cares/1/edit
  def edit
  end

  # POST /cares
  # POST /cares.json
  def create
    @care = Care.new(care_params)
    respond_to do |format|
      if @care.save
        format.html { redirect_to @care, notice: 'Care was successfully created.' }
        format.json { render :show, status: :created, location: @care }
      else
        format.html { render :new }
        format.json { render json: @care.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cares/1
  # PATCH/PUT /cares/1.json
  def update
    respond_to do |format|
      if @care.update(care_params)
        format.html { redirect_to @care, notice: 'Care was successfully updated.' }
        format.json { render :show, status: :ok, location: @care }
      else
        format.html { render :edit }
        format.json { render json: @care.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cares/1
  # DELETE /cares/1.json
  def destroy
    @care.destroy
    respond_to do |format|
      format.html { redirect_to cares_url, notice: 'Care was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_care
      @care = Care.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def care_params
      params.require(:care).permit(:fed, :medicated, :fedAt, :medicatedAt)
    end
end
