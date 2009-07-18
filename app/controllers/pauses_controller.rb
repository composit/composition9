class PausesController < ApplicationController
  
  layout "admin"

  before_filter :login_required

  # GET /pauses
  # GET /pauses.xml
  def index
    if current_user.is_admin
      @pauses = Pause.find(:all)
    else
      @pauses = current_user.pauses.find(:all)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pauses }
    end
  end

  # GET /pauses/1
  # GET /pauses/1.xml
  def show
    @pause = Pause.find(params[:id])

    if current_user.is_admin || @pause.user == current_user
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @pause }
      end
    else
      redirect_to new_session_path
    end
  end

  # GET /pauses/new
  # GET /pauses/new.xml
  def new
    @pause = Pause.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pause }
    end
  end

  # GET /pauses/1/edit
  def edit
    @pause = Pause.find(params[:id])
    unless current_user.is_admin || @pause.user == current_user
      redirect_to new_session_path
    end
  end

  # POST /pauses
  # POST /pauses.xml
  def create
    @pause = Pause.new(params[:pause])

    if current_user.is_admin || @pause.user == current_user
      respond_to do |format|
        if @pause.save
          flash[:notice] = 'Pause was successfully created.'
          format.html { redirect_to(@pause) }
          format.xml  { render :xml => @pause, :status => :created, :location => @pause }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @pause.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to new_session_path
    end
  end

  # PUT /pauses/1
  # PUT /pauses/1.xml
  def update
    @pause = Pause.find(params[:id])

    if current_user.is_admin || @pause.user == current_user
      respond_to do |format|
        if @pause.update_attributes(params[:pause])
          flash[:notice] = 'Pause was successfully updated.'
          format.html { redirect_to(@pause) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @pause.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to new_session_path
    end
  end

  # DELETE /pauses/1
  # DELETE /pauses/1.xml
  def destroy
    @pause = Pause.find(params[:id])
    if current_user.is_admin || @pause.user == current_user
      @pause.destroy

      respond_to do |format|
        format.html { redirect_to(pauses_url) }
        format.xml  { head :ok }
      end
    else
      redirect_to new_session_path
    end
  end
end
