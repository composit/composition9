class InvoiceAdjustmentLinesController < ApplicationController
  # GET /invoice_adjustment_lines
  # GET /invoice_adjustment_lines.xml
  def index
    @invoice_adjustment_lines = InvoiceAdjustmentLine.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invoice_adjustment_lines }
    end
  end

  # GET /invoice_adjustment_lines/1
  # GET /invoice_adjustment_lines/1.xml
  def show
    @invoice_adjustment_line = InvoiceAdjustmentLine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invoice_adjustment_line }
    end
  end

  # GET /invoice_adjustment_lines/new
  # GET /invoice_adjustment_lines/new.xml
  def new
    @invoice_adjustment_line = InvoiceAdjustmentLine.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @invoice_adjustment_line }
    end
  end

  # GET /invoice_adjustment_lines/1/edit
  def edit
    @invoice_adjustment_line = InvoiceAdjustmentLine.find(params[:id])
  end

  # POST /invoice_adjustment_lines
  # POST /invoice_adjustment_lines.xml
  def create
    @invoice_adjustment_line = InvoiceAdjustmentLine.new(params[:invoice_adjustment_line])

    respond_to do |format|
      if @invoice_adjustment_line.save
        flash[:notice] = 'InvoiceAdjustmentLine was successfully created.'
        format.html { redirect_to(@invoice_adjustment_line) }
        format.xml  { render :xml => @invoice_adjustment_line, :status => :created, :location => @invoice_adjustment_line }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @invoice_adjustment_line.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /invoice_adjustment_lines/1
  # PUT /invoice_adjustment_lines/1.xml
  def update
    @invoice_adjustment_line = InvoiceAdjustmentLine.find(params[:id])

    respond_to do |format|
      if @invoice_adjustment_line.update_attributes(params[:invoice_adjustment_line])
        flash[:notice] = 'InvoiceAdjustmentLine was successfully updated.'
        format.html { redirect_to(@invoice_adjustment_line) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invoice_adjustment_line.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /invoice_adjustment_lines/1
  # DELETE /invoice_adjustment_lines/1.xml
  def destroy
    @invoice_adjustment_line = InvoiceAdjustmentLine.find(params[:id])
    @invoice_adjustment_line.destroy

    respond_to do |format|
      format.html { redirect_to(invoice_adjustment_lines_url) }
      format.xml  { head :ok }
    end
  end
end
