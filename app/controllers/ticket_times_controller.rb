class TicketTimesController < ApplicationController
  layout "admin"

  before_filter :login_required

  # GET /ticket_times
  # GET /ticket_times.xml
  def index
    @ticket_times = TicketTime.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ticket_times }
    end
  end

  # GET /ticket_times/1
  # GET /ticket_times/1.xml
  def show
    @ticket_time = TicketTime.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ticket_time }
    end
  end

  # GET /ticket_times/new
  # GET /ticket_times/new.xml
  def new
    @ticket_time = TicketTime.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticket_time }
      format.js   { render :partial => "/users/user", :object => current_user }
    end
  end

  # GET /ticket_times/1/edit
  def edit
    @ticket_time = TicketTime.find(params[:id])
  end

  # POST /ticket_times
  # POST /ticket_times.xml
  def create
    @ticket_time = TicketTime.new(params[:ticket_time])

    current_user.ticket_times.find(:all, :conditions => "end_time is null").each do |ticket_time|
      ticket_time.update_attributes( :end_time => Time.zone.now )
    end

    respond_to do |format|
      if @ticket_time.save
        flash[:notice] = 'TicketTime was successfully created.'
        format.html { redirect_to(@ticket_time) }
        format.xml  { render :xml => @ticket_time, :status => :created, :location => @ticket_time }
        format.js   { render :partial => "/users/user", :object => current_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ticket_time.errors, :status => :unprocessable_entity }
        format.js   { render :partial => "/users/user", :object => current_user }
      end
    end
  end

  # PUT /ticket_times/1
  # PUT /ticket_times/1.xml
  def update
    @ticket_time = TicketTime.find(params[:id])

    respond_to do |format|
      if @ticket_time.update_attributes(params[:ticket_time])
        flash[:notice] = 'TicketTime was successfully updated.'
        format.html { redirect_to(@ticket_time) }
        format.xml  { head :ok }
        format.js   { render :partial => "/users/user", :object => current_user }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticket_time.errors, :status => :unprocessable_entity }
        format.js   { render :partial => "/users/user", :object => current_user }
      end
    end
  end

  # DELETE /ticket_times/1
  # DELETE /ticket_times/1.xml
  def destroy
    @ticket_time = TicketTime.find(params[:id])
    @ticket_time.destroy

    respond_to do |format|
      format.html { redirect_to(ticket_times_url) }
      format.xml  { head :ok }
    end
  end

  protected

    def authorized?
      logged_in? && current_user.is_admin
    end
end
