class NodeTypesController < ApplicationController
  before_action :set_node_type, only: [:show, :edit, :update, :destroy]

  # GET /node_types
  # GET /node_types.json
  def index
    @node_types = NodeType.all
  end

  # GET /node_types/1
  # GET /node_types/1.json
  def show
  end

  # GET /node_types/new
  def new
    @node_type = NodeType.new
  end

  # GET /node_types/1/edit
  def edit
  end

  # POST /node_types
  # POST /node_types.json
  def create
    @node_type = NodeType.new(node_type_params)

    respond_to do |format|
      if @node_type.save
        format.html { redirect_to @node_type, notice: 'Node type was successfully created.' }
        format.json { render :show, status: :created, location: @node_type }
      else
        format.html { render :new }
        format.json { render json: @node_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /node_types/1
  # PATCH/PUT /node_types/1.json
  def update
    respond_to do |format|
      if @node_type.update(node_type_params)
        format.html { redirect_to @node_type, notice: 'Node type was successfully updated.' }
        format.json { render :show, status: :ok, location: @node_type }
      else
        format.html { render :edit }
        format.json { render json: @node_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /node_types/1
  # DELETE /node_types/1.json
  def destroy
    @node_type.destroy
    respond_to do |format|
      format.html { redirect_to node_types_url, notice: 'Node type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node_type
      @node_type = NodeType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def node_type_params
      params.require(:node_type).permit(:name)
    end
end
