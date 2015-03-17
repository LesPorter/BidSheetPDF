class GranitesController < ApplicationController
  before_action :set_granite, only: [:show, :edit, :update, :destroy]

  # GET /granites
  # GET /granites.json
  def index
    @granites = Granite.all
  end

  # GET /granites/1
  # GET /granites/1.json
  def show
  end

  # GET /granites/new
  def new
    @granite = Granite.new
  end

  # GET /granites/1/edit
  def edit
  end

  # POST /granites
  # POST /granites.json
  def create
    @granite = Granite.new(granite_params)

    respond_to do |format|
      if @granite.save
        format.html { redirect_to @granite, notice: 'Granite was successfully created.' }
        format.json { render :show, status: :created, location: @granite }
      else
        format.html { render :new }
        format.json { render json: @granite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /granites/1
  # PATCH/PUT /granites/1.json
  def update
    respond_to do |format|
      if @granite.update(granite_params)
        format.html { redirect_to @granite, notice: 'Granite was successfully updated.' }
        format.json { render :show, status: :ok, location: @granite }
      else
        format.html { render :edit }
        format.json { render json: @granite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /granites/1
  # DELETE /granites/1.json
  def destroy
    @granite.destroy
    respond_to do |format|
      format.html { redirect_to granites_url, notice: 'Granite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_granite
      @granite = Granite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def granite_params
      params.require(:granite).permit(:name, :image)
    end
end
