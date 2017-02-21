class TelescopesController < ApplicationController
  before_action :set_telescope, only: [:show, :update, :destroy]

  # GET /telescopes
  def index
    @telescopes = Telescope.all

    render json: @telescopes
  end

  # GET /telescopes/1
  def show
    render json: @telescope
  end

  # POST /telescopes
  def create
    @telescope = Telescope.new(telescope_params)

    if @telescope.save
      render json: @telescope, status: :created, location: @telescope
    else
      render json: @telescope.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /telescopes/1
  def update
    if @telescope.update(telescope_params)
      render json: @telescope
    else
      render json: @telescope.errors, status: :unprocessable_entity
    end
  end

  # DELETE /telescopes/1
  def destroy
    @telescope.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_telescope
      @telescope = Telescope.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def telescope_params
      params.require(:telescope).permit(:name, :regime, :operator, :cospar_id)
    end
end
