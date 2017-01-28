require 'jwt'
require 'constants'

class DistFilesController < ApplicationController
  include Constants
  include DistFilesHelper

  before_action :set_dist_file, only: [:show, :edit, :update, :destroy, :download]
  protect_from_forgery except: [:download, :create]
  before_action :is_user_authenticated?

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
    node_address = get_file_from_node(@dist_file.id)
    if node_address
      redirect_to node_address
    else
      head :unauthorized
    end
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
    Rails.logger.debug request.headers['Content-Type']
    @dist_file = DistFile.new(dist_file_params)
    @dist_file.user_id = (@token) ? @token[0]["user_id"] : current_user.id

    respond_to do |format|
      if @dist_file.save
        if @token
          format.html { head :created }
        else
          ReplicaWorker.perform_async(@dist_file.name, -1, @dist_file.attached.path,
        current_user.get_token, UPLOAD_REQUEST)

          format.html { redirect_to @dist_file, notice: 'Dist file was successfully created.' }
          format.json { render :show, status: :created, location: @dist_file }
        end
      else
        if @token
          head :unprocessable_entity
        else
          format.html { render :new }
          format.json { render json: @dist_file.errors, status: :unprocessable_entity }
        end
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
      if @token
        format.html { head :ok }
      else
        ReplicaWorker.perform_async("", @dist_file.id, "",  current_user.get_token, DELETE_REQUEST)
        format.html { redirect_to dist_files_url, notice: 'Dist file was successfully destroyed.' }
        format.json { head :no_content }
      end
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

    def is_token_valid?
      @token = JWT.decode(params[:token], Rails.application.secrets.secret_key_base)
      return (@token) ? true : false
    end

    def is_user_authenticated?
      if params.key? :token
        @token = JWT.decode(params[:token], Rails.application.secrets.secret_key_base)
        return (@token[0]["available_files_by_id"].count(params[:id]))
      else
        @token = false
        authenticate_user!
      end
    end
end
