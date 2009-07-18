class InvoicesController < ApplicationController
  layout "admin", :except => :show

  before_filter :login_required

  # GET /invoices
  # GET /invoices.xml
  def index
    if params[:client_id]
      @client = Client.find(params[:client_id])
      @invoices = @client.invoices
    else
      @invoices = Invoice.find(:all)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invoices }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.xml
  def show
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invoice }
      format.pdf  { prawnto :filename => @invoice.invoice_number + '.pdf', :inline => true }
    end
  end

  # GET /invoices/new
  # GET /invoices/new.xml
  def new
    if current_user.is_admin && params[:client_id]
      @client = Client.find( params[:client_id] )
      @invoice = Invoice.new(
        :client_id => @client.id,
        :invoice_date => Date.today
      )

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @invoice }
      end
    else
      redirect_to new_session_path
    end
  end

  # GET /invoices/1/edit
  def edit
    if current_user.is_admin
      @invoice = Invoice.find(params[:id])
    else
      redirect_to new_session_path
    end
  end

  # POST /invoices
  # POST /invoices.xml
  def create
    @client = Client.find(params[:invoice][:client_id])
    if current_user.is_admin
      @invoice = Invoice.new(params[:invoice])

      respond_to do |format|
        if @invoice.save
          flash[:notice] = 'Invoice was successfully created.'
          format.html { redirect_to invoices_path( :client_id  => @invoice.client_id ) }
          format.xml  { render :xml => @invoice, :status => :created, :location => @invoice }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to new_session_path
    end
  end

  # PUT /invoices/1
  # PUT /invoices/1.xml
  def update
    if current_user.is_admin
      @invoice = Invoice.find(params[:id])

      respond_to do |format|
        if @invoice.update_attributes(params[:invoice])
          flash[:notice] = 'Invoice was successfully updated.'
          format.html { redirect_to(@invoice) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to new_session_path
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.xml
  def destroy
    if current_user.is_admin
      @invoice = Invoice.find(params[:id])
      @invoice.destroy

      respond_to do |format|
        format.html { redirect_to(invoices_url) }
        format.xml  { head :ok }
      end
    else
      redirect_to new_session_path
    end
  end

  protected
    def authorized?
      if params[:client_id]
        client = Client.find(params[:client_id])
      elsif params[:id]
        client = Invoice.find(params[:id]).client
      end
      logged_in? && ( current_user.is_admin || ( client && current_user.can_view_client_invoices?(client.id) ) )
    end

end
