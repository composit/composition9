class TicketsController < ApplicationController
  layout "admin"

  before_filter :login_required

  # GET /tickets
  # GET /tickets.xml
  def index
    if current_user.is_admin
      @tickets = Ticket.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @tickets }
      end
    else
      redirect_to new_session_path
    end
  end

  # GET /tickets/1
  # GET /tickets/1.xml
  def show
    if current_user.is_admin
      @ticket = Ticket.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @ticket }
      end
    else
      redirect_to new_session_path
    end
  end

  # GET /tickets/new
  # GET /tickets/new.xml
  def new
    if current_user.is_admin
      @ticket = Ticket.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @ticket }
      end
    else
      redirect_to new_session_path
    end
  end

  # GET /tickets/1/edit
  def edit
    if current_user.is_admin
      @ticket = Ticket.find(params[:id])
    else
      redirect_to new_session_path
    end
  end

  # POST /tickets
  # POST /tickets.xml
  def create
    if current_user.is_admin
      @ticket = Ticket.new(params[:ticket])

      respond_to do |format|
        if @ticket.save
          flash[:notice] = 'Ticket was successfully created.'
          format.html { redirect_to(@ticket) }
          format.xml  { render :xml => @ticket, :status => :created, :location => @ticket }
          format.js   { render :partial => '/projects/projects_client', :object => @ticket.project.client, :locals => { :expanded_project => @ticket.project } }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
          format.js   { render :partial => '/projects/projects_client', :object => @ticket.project.client, :locals => { :expanded_project => @ticket.project } }
        end
      end
    else
      redirect_to new_session_path
    end
  end

  # PUT /tickets/1
  # PUT /tickets/1.xml
  def update
    if current_user.is_admin
      @ticket = Ticket.find(params[:id])

      respond_to do |format|
        if @ticket.update_attributes(params[:ticket])
          flash[:notice] = 'Ticket was successfully updated.'
          format.html { redirect_to(@ticket) }
          format.xml  { head :ok }
          format.js   { render :partial => '/projects/projects_client', :object => @ticket.project.client, :locals => { :expanded_project => @ticket.project } }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
          format.js   { render :partial => '/projects/projects_client', :object => @ticket.project.client, :locals => { :expanded_project => @ticket.project } }
        end
      end
    else
      redirect_to new_session_path
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.xml
  def destroy
    if current_user.is_admin
      @ticket = Ticket.find(params[:id])
      @ticket.destroy

      respond_to do |format|
        format.html { redirect_to(tickets_url) }
        format.xml  { head :ok }
      end
    else
      redirect_to new_session_path
    end
  end
end
