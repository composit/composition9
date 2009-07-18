class ClientUsersController < ApplicationController

  layout "admin"

  before_filter :login_required

  # GET /client_users
  # GET /client_users.xml
  def index
    @client_users = ClientUser.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @client_users }
    end
  end

  # GET /client_users/1
  # GET /client_users/1.xml
  def show
    @client_user = ClientUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @client_user }
    end
  end

  # GET /client_users/new
  # GET /client_users/new.xml
  def new
    @client_user = ClientUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @client_user }
    end
  end

  # GET /client_users/1/edit
  def edit
    @client_user = ClientUser.find(params[:id])
  end

  # POST /client_users
  # POST /client_users.xml
  def create
    @client_user = ClientUser.new(params[:client_user])

    respond_to do |format|
      if @client_user.save
        flash[:notice] = 'ClientUser was successfully created.'
        format.html { redirect_to(@client_user) }
        format.xml  { render :xml => @client_user, :status => :created, :location => @client_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @client_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /client_users/1
  # PUT /client_users/1.xml
  def update
    if request.xhr?
      params[:clients].each_with_index do |id, position|
        ClientUser.update(id, :priority => position)
      end
      render :nothing => true
    else
      @client_user = ClientUser.find(params[:id])

      respond_to do |format|
        if @client_user.update_attributes(params[:client_user])
          flash[:notice] = 'ClientUser was successfully updated.'
          format.html { redirect_to(@client_user) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @client_user.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /client_users/1
  # DELETE /client_users/1.xml
  def destroy
    @client_user = ClientUser.find(params[:id])
    @client_user.destroy

    respond_to do |format|
      format.html { redirect_to(client_users_url) }
      format.xml  { head :ok }
    end
  end

  protected

    def authorized?
      logged_in? && current_user.is_admin
    end
end
