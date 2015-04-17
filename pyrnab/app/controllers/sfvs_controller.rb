class SfvsController < ApplicationController
  before_action :set_sfv, only: [:show, :edit, :update, :destroy]

  # GET /sfvs
  # GET /sfvs.json
  def index
    @sfvs = Sfv.all
  end

  # GET /sfvs/1
  # GET /sfvs/1.json
  def show
    respond_to do |format|
      release = Release.where(:sfv_id => @sfv.id).limit(1)
      if !(release[0].nil?)
        format.html {send_data ActiveSupport::Gzip.decompress(@sfv.data), :filename => "#{release[0].name}.sfv" }
      end
    end
  end

  # GET /sfvs/new
  def new
    @sfv = Sfv.new
  end

  # GET /sfvs/1/edit
  def edit
  end

  # POST /sfvs
  # POST /sfvs.json
  def create
    @sfv = Sfv.new(sfv_params)

    respond_to do |format|
      if @sfv.save
        format.html { redirect_to @sfv, notice: 'Sfv was successfully created.' }
        format.json { render :show, status: :created, location: @sfv }
      else
        format.html { render :new }
        format.json { render json: @sfv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sfvs/1
  # PATCH/PUT /sfvs/1.json
  def update
    respond_to do |format|
      if @sfv.update(sfv_params)
        format.html { redirect_to @sfv, notice: 'Sfv was successfully updated.' }
        format.json { render :show, status: :ok, location: @sfv }
      else
        format.html { render :edit }
        format.json { render json: @sfv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sfvs/1
  # DELETE /sfvs/1.json
  def destroy
    @sfv.destroy
    respond_to do |format|
      format.html { redirect_to sfvs_url, notice: 'Sfv was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sfv
      @sfv = Sfv.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sfv_params
      params.require(:sfv).permit(:id, :data)
    end
end
