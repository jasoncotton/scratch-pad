class NfosController < ApplicationController
  before_action :set_nfo, only: [:show, :edit, :update, :destroy]

  # GET /nfos
  # GET /nfos.json
  def index
    @nfos = Nfo.all.limit(10)
  end

  # GET /nfos/1
  # GET /nfos/1.json
  def show
    respond_to do |format|
      release = Release.where(:nfo_id => @nfo.id).limit(1)
      if !(release[0].nil?)
        format.html {send_data ActiveSupport::Gzip.decompress(@nfo.data), :filename => "#{release[0].name}.nfo" }
      end
    end
  end

  # GET /nfos/new
  def new
    @nfo = Nfo.new
  end

  # GET /nfos/1/edit
  def edit
  end

  # POST /nfos
  # POST /nfos.json
  def create
    @nfo = Nfo.new(nfo_params)

    respond_to do |format|
      if @nfo.save
        format.html { redirect_to @nfo, notice: 'Nfo was successfully created.' }
        format.json { render :show, status: :created, location: @nfo }
      else
        format.html { render :new }
        format.json { render json: @nfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nfos/1
  # PATCH/PUT /nfos/1.json
  def update
    respond_to do |format|
      if @nfo.update(nfo_params)
        format.html { redirect_to @nfo, notice: 'Nfo was successfully updated.' }
        format.json { render :show, status: :ok, location: @nfo }
      else
        format.html { render :edit }
        format.json { render json: @nfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nfos/1
  # DELETE /nfos/1.json
  def destroy
    @nfo.destroy
    respond_to do |format|
      format.html { redirect_to nfos_url, notice: 'Nfo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nfo
      @nfo = Nfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nfo_params
      params.require(:nfo).permit(:id, :data)
    end
end
