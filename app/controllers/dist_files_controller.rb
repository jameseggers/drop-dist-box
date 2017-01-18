require 'jwt'

class DistFilesController < ApplicationController
  before_action :set_dist_file, only: [:show, :edit, :update, :destroy, :download]
  before_action :is_able_to_download?, only: :download
  before_action :authenticate_user!, except: :download

  # GET /dist_files
  # GET /dist_files.json
  def index
    @dist_files = DistFile.all
  end

  # GET /dist_files/1
  # GET /dist_files/1.json
  def show
  end

  def download
    send_file @dist_file.attached.path,
                filename: @dist_file.attached.file_name,
                type: @dist_file.attached.content_type,
                disposition: 'attachment'
  end

  # GET /dist_files/new
  def new
    @dist_file = DistFile.new
  end

  # GET /dist_files/1/edit
  def edit
  end

  # POST /dist_files
  # POST /dist_files.json
  def create
    @dist_file = DistFile.new(dist_file_params)

    respond_to do |format|
      if @dist_file.save
        format.html { redirect_to @dist_file, notice: 'Dist file was successfully created.' }
        format.json { render :show, status: :created, location: @dist_file }
      else
        format.html { render :new }
        format.json { render json: @dist_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dist_files/1
  # PATCH/PUT /dist_files/1.json
  def update
    respond_to do |format|
      if @dist_file.update(dist_file_params)
        format.html { redirect_to @dist_file, notice: 'Dist file was successfully updated.' }
        format.json { render :show, status: :ok, location: @dist_file }
      else
        format.html { render :edit }
        format.json { render json: @dist_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dist_files/1
  # DELETE /dist_files/1.json
  def destroy
    @dist_file.destroy
    respond_to do |format|
      format.html { redirect_to dist_files_url, notice: 'Dist file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dist_file
      @dist_file = DistFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dist_file_params
      params.require(:dist_file).permit(:name, :attached)
    end

    def is_able_to_download?
      token = JWT.decode(params[:token], Rails.application.secrets.secret_key_base)
      return (token) ? token : false
    end
end
