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
    
    # Draw the X and Y axis - COMMENT OUT IN PRODUCTION
    # pdf.stroke_axis
    
    # Draw the bid sheet
    # -------------------------------------------------------------------------
    # Top of the document is y = 720.0
    
    # Header
    logo_image = @bid.logo
    pdf.image "app/assets/images/" + logo_image.to_s, :at => [0, 720], :width => 70, :height => 70
    pdf.draw_text @bid.client_name, :at => [87,705], :size => 20
    pdf.draw_text @bid.project_name, :at => [87,672], :size => 30, :style => :bold
    
    # Format date
    month = @bid.date.strftime('%B')
    day = @bid.date.strftime('%d')
    year = @bid.date.strftime('%Y')
    formatted_date = month + " " + day + ", " + year
    pdf.draw_text formatted_date, :at => [88,650], :size => 10
    
    # Left column
    # -------------------------------------------------------------------------
    
    pdf.draw_text "Project Costs", :at => [0,618], :size => 18
    
    # Format currency
    cabinet_cost = format("$%.2f",@bid.cabinet_cost)  # Round cents to 2 digits & add a dollar sign
    cabinet_cost = cabinet_cost.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse  # Add a comma every 3 digits

    granite_cost = format("$%.2f",@bid.granite_cost)
    granite_cost = granite_cost.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    
    tax_cost = format("$%.2f",@bid.tax_cost)
    tax_cost = tax_cost.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    
    total_cost = format("$%.2f",@bid.total_cost)
    total_cost = total_cost.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    
    pdf.draw_text "Cabinets", :at => [0,593], :size => 14
    pdf.draw_text cabinet_cost, :at => [0,567], :size => 30
    
    # Assemble include statement for cabinets
    cabinet_includes = ""
    cabinet_includes_count = 0
    # Make a string of includes, separated by commas
    if @bid.cabinet_delivery == true
      cabinet_includes_count += 1
      cabinet_includes = "delivery, "
    end
    if @bid.cabinet_removal == true
      cabinet_includes_count += 1
      cabinet_includes = cabinet_includes + "removal, "
    end
    if @bid.cabinet_installation == true
      cabinet_includes_count += 1
      cabinet_includes = cabinet_includes + "installation, "
    end
    if @bid.cabinet_knobspulls == true
      cabinet_includes_count += 1
      cabinet_includes = cabinet_includes + "knobs/pulls, "
    end
    if @bid.cabinet_tax == true
      cabinet_includes_count += 1
      cabinet_includes = cabinet_includes + "taxes, "
    end
    # Remove the trailing comma and space
    cabinet_includes = cabinet_includes[0...-2]
    # If there are just two includes use " and " instead of a comma
    if cabinet_includes_count == 2
      cabinet_includes.gsub! ', ', ' and '
    end
    # Add the beginning and end of the sentence if there's at least one include.
    if cabinet_includes_count > 0
      cabinet_includes = "Includes " + cabinet_includes + "."
    end
    pdf.font_size 9
    pdf.bounding_box([0, 561], :width => 207, :height => 30) do
      pdf.transparent(0.0) { pdf.stroke_bounds }
      pdf.text cabinet_includes
    end
    
    pdf.draw_text "Counter Tops", :at => [0,506], :size => 14
    pdf.draw_text granite_cost, :at => [0,480], :size => 30
    
    # Assemble include statement for counter tops
    counter_includes = ""
    counter_includes_count = 0
    # Make a string of includes, separated by commas
    if @bid.granite_installation == true
      counter_includes_count += 1
      counter_includes = "installation, "
    end
    if @bid.granite_sinks == true
      counter_includes_count += 1
      counter_includes = counter_includes + "sinks, "
    end
    if @bid.granite_specialtyedge == true
      counter_includes_count += 1
      counter_includes = counter_includes + "specialty edge, "
    end
    if @bid.granite_tax == true
      counter_includes_count += 1
      counter_includes = counter_includes + "taxes, "
    end
    # Remove the trailing comma and space
    counter_includes = counter_includes[0...-2]
    # If there are just two includes use " and " instead of a comma
    if counter_includes_count == 2
      counter_includes.gsub! ', ', ' and '
    end
    # Add the beginning and end of the sentence if there's at least one include.
    if counter_includes_count > 0
      counter_includes = "Includes " + counter_includes + "."
    end
    pdf.font_size 9
    pdf.bounding_box([0, 474], :width => 207, :height => 30) do
      pdf.transparent(0.0) { pdf.stroke_bounds }
      pdf.text counter_includes
    end
    
#     pdf.draw_text "Tax", :at => [0,479], :size => 14
#     pdf.draw_text tax_cost, :at => [0,453], :size => 30
    pdf.draw_text "Total", :at => [0,422], :size => 14
    pdf.draw_text total_cost, :at => [0,396], :size => 30
    
    pdf.draw_text "Conditions & Information", :at => [0,360], :size => 18
    conditions = @bid.conditions
    pdf.font_size 9
    pdf.bounding_box([0, 340], :width => 207, :height => 290) do
      pdf.transparent(0.0) { pdf.stroke_bounds }
      pdf.text conditions
    end
    
    # Center column
    # -------------------------------------------------------------------------
    
    pdf.draw_text "Cabinet Mix", :at => [220,618], :size => 18
    pdf.draw_text "Qty", :at => [220,596], :size => 10, :style => :bold
    pdf.draw_text "SKU", :at => [250,596], :size => 10, :style => :bold
    cabinet_mix = @bid.cabinet_mix
    
    # Replace the tab copied & pasted from the spreadsheet with spaces & hyphens
    cabinet_mix = cabinet_mix.gsub! /\t/, '   --   '
    pdf.font_size 9
    pdf.bounding_box([225, 590], :width => 110, :height => 540) do
      pdf.transparent(0.0) { pdf.stroke_bounds }  # Change 0.0 to 0.5 to turn on the border
      pdf.text cabinet_mix
    end
    
    # Right column
    # -------------------------------------------------------------------------
    
    cabinet_name = @bid.cabinet.name
    pdf.draw_text cabinet_name, :at => [347,618], :size => 18
    
    # Embed the cabinet image
    cabinet_image = @bid.cabinet.image
    pdf.image "public/" + cabinet_image.to_s, :at => [347, 603], :width => 190, :height => 190
    
    cabinet_specs = @bid.cabinet.specs
    pdf.font_size 9
    pdf.bounding_box([347, 400], :width => 190, :height => 120) do
      pdf.transparent(0.0) { pdf.stroke_bounds }  # Change 0.0 to 0.5 to turn on the border
      pdf.text cabinet_specs
    end
    granite_name = @bid.granite.name
    pdf.draw_text granite_name, :at => [347,255], :size => 18
    
    # Embed the granite image
    granite_image = @bid.granite.image
    pdf.image "public/" + granite_image.to_s, :at => [347, 240], :width => 190, :height => 190
    
    # Bottom row
    # -------------------------------------------------------------------------
    
    pdf.fill_rectangle [0, 15], 120, 3
    pdf.draw_text "Signature", :at => [0,0], :size => 10
    pdf.fill_rectangle [139, 15], 120, 3
    pdf.draw_text "Full Name", :at => [139,0], :size => 10
    pdf.fill_rectangle [278, 15], 120, 3
    pdf.draw_text "Company", :at => [278,0], :size => 10
    pdf.fill_rectangle [417, 15], 120, 3
    pdf.draw_text "Date", :at => [417,0], :size => 10
    
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
      params.require(:bid).permit(:logo, :client_name, :project_name, :date, :cabinet_cost, :cabinet_delivery, :cabinet_removal, :cabinet_installation, :cabinet_knobspulls, :cabinet_tax, :granite_cost, :granite_tax, :granite_installation, :granite_sinks, :granite_specialtyedge, :total_cost, :conditions, :cabinet_mix, :cabinet_id, :granite_id)
    end
end
