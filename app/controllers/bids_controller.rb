class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]

  # GET /bids
  # GET /bids.json
  def index
    @bids = Bid.all
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
    
    # Create the document object
    pdf = Prawn::Document.new
    # pdf.text "Hello World."
    
    # Draw the X and Y axis - COMMENT OUT IN PRODUCTION
    pdf.stroke_axis
    
    # Draw the bid sheet
    # -------------------------------------------------------------------------
    # Top of the document is y = 720.0
    
    # Header
    pdf.fill_rectangle [0, 700], 70, 70
    pdf.draw_text @bid.client_name, :at => [87,685], :size => 20
    pdf.draw_text @bid.project_name, :at => [87,652], :size => 30#, :style => [:bold]
    
    # Format date
    month = @bid.date.strftime('%B')
    day = @bid.date.strftime('%d')
    year = @bid.date.strftime('%Y')
    formatted_date = month + " " + day + ", " + year
    pdf.draw_text formatted_date, :at => [88,630], :size => 10
    
    # Left column
    pdf.draw_text "Project Costs", :at => [0,598], :size => 18
    
    # Format currency
    cabinet_cost = format("$%.2f",@bid.cabinet_cost)
    granite_cost = format("$%.2f",@bid.granite_cost)
    tax_cost = format("$%.2f",@bid.tax_cost)
    total_cost = format("$%.2f",@bid.total_cost)
    
    pdf.draw_text "Cabinets with Installation", :at => [0,573], :size => 14
    pdf.draw_text cabinet_cost, :at => [0,547], :size => 30
    pdf.draw_text "Granite with Installation", :at => [0,516], :size => 14
    pdf.draw_text granite_cost, :at => [0,490], :size => 30
    pdf.draw_text "Tax", :at => [0,459], :size => 14
    pdf.draw_text tax_cost, :at => [0,433], :size => 30
    pdf.draw_text "Total", :at => [0,402], :size => 14
    pdf.draw_text total_cost, :at => [0,376], :size => 30
    
    pdf.draw_text "Conditions & Information", :at => [0,320], :size => 18
    conditions = @bid.conditions
    pdf.bounding_box([0, 300], :width => 207, :height => 250) do
      pdf.transparent(0.5) { pdf.stroke_bounds }
      pdf.text conditions
    end
    
    # Center column
    pdf.draw_text "Project Costs", :at => [220,598], :size => 18
    pdf.draw_text "Qty", :at => [220,576], :size => 10
    cabinet_mix = @bid.cabinet_mix
    pdf.bounding_box([220, 570], :width => 115, :height => 520) do
      pdf.transparent(0.5) { pdf.stroke_bounds }
      pdf.text cabinet_mix
    end
    
    # Right column
    pdf.draw_text "Cabinet Style Name", :at => [347,598], :size => 18
    pdf.fill_rectangle [347, 583], 190, 190
    
    # Produce the PDF
    # -------------------------------------------------------------------------
    
    # Use the bid ID to name the PDF file
    pdf.render_file "public/pdfs/" + @bid.id.to_s + ".pdf"
    
  end

  # GET /bids/new
  def new
    @bid = Bid.new
  end

  # GET /bids/1/edit
  def edit
  end

  # POST /bids
  # POST /bids.json
  def create
    @bid = Bid.new(bid_params)

    respond_to do |format|
      if @bid.save
        format.html { redirect_to @bid, notice: 'Bid was successfully created.' }
        format.json { render :show, status: :created, location: @bid }
      else
        format.html { render :new }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bids/1
  # PATCH/PUT /bids/1.json
  def update
    respond_to do |format|
      if @bid.update(bid_params)
        format.html { redirect_to @bid, notice: 'Bid was successfully updated.' }
        format.json { render :show, status: :ok, location: @bid }
      else
        format.html { render :edit }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to bids_url, notice: 'Bid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.require(:bid).permit(:logo, :client_name, :project_name, :date, :cabinet_cost, :granite_cost, :tax_cost, :total_cost, :conditions, :cabinet_mix, :cabinet_id, :granite_id)
    end
end
