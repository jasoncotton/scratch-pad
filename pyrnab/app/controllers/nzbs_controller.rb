class NzbsController < ApplicationController
  before_action :set_nzb, only: [:show, :edit, :update, :destroy]

  # GET /nzbs
  # GET /nzbs.json
  def index
    @nzbs = Nzb.all.limit(10)
  end

  # GET /nzbs/1
  # GET /nzbs/1.json
  def show
    respond_to do |format|
      release = Release.where(:nzb_id => @nzb.id).limit(1)
      if !(release[0].nil?)
        format.html {send_data ActiveSupport::Gzip.decompress(@nzb.data), :filename => "#{release[0].name}.nzb" }
      end
    end
  end

  # GET /nzbs/new
  def new
    @nzb = Nzb.new
  end

  # GET /nzbs/1/edit
  def edit
  end

  # POST /nzbs
  # POST /nzbs.json
  def create
    @nzb = Nzb.new(nzb_params)

    respond_to do |format|
      if @nzb.save
        format.html { redirect_to @nzb, notice: 'Nzb was successfully created.' }
        format.json { render :show, status: :created, location: @nzb }
      else
        format.html { render :new }
        format.json { render json: @nzb.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nzbs/1
  # PATCH/PUT /nzbs/1.json
  def update
    respond_to do |format|
      if @nzb.update(nzb_params)
        format.html { redirect_to @nzb, notice: 'Nzb was successfully updated.' }
        format.json { render :show, status: :ok, location: @nzb }
      else
        format.html { render :edit }
        format.json { render json: @nzb.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nzbs/1
  # DELETE /nzbs/1.json
  def destroy
    @nzb.destroy
    respond_to do |format|
      format.html { redirect_to nzbs_url, notice: 'Nzb was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nzb
      @nzb = Nzb.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nzb_params
      params.require(:nzb).permit(:id, :data)
    end
end
