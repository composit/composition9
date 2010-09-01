class UserPausesController < ApplicationController

  layout "admin"

  before_filter :login_required

  # GET /user_pauses
  # GET /user_pauses.xml
  def index
    if current_user.is_admin
      @user_pauses = UserPause.all
    else
      @user_pauses = current_user.user_pauses
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_pauses }
    end
  end

  # GET /user_pauses/1
  # GET /user_pauses/1.xml
  def show
    @user_pause = UserPause.find(params[:id])
    if current_user.is_admin || @user_pause.user == current_user

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @user_pause }
      end
    else
      redirect_to new_session_path
    end
  end

  # GET /user_pauses/new
  # GET /user_pauses/new.xml
  def new
    @user_pause = UserPause.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_pause }
    end
  end

  # GET /user_pauses/1/edit
  def edit
    @user_pause = UserPause.find(params[:id])
    unless current_user.is_admin || @user_pause.user == current_user
      redirect_to new_session_path
    end
  end

  # POST /user_pauses
  # POST /user_pauses.xml
  def create
    @user_pause = UserPause.new(params[:user_pause])

    if current_user.is_admin || @user_pause.user == current_user
      respond_to do |format|
        if @user_pause.save
          flash[:notice] = 'UserPause was successfully created.'
          format.html { redirect_to(@user_pause) }
          format.xml  { render :xml => @user_pause, :status => :created, :location => @user_pause }
          format.js   { render :partial => "/users/user", :object => current_user }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @user_pause.errors, :status => :unprocessable_entity }
          format.js   { render :partial => "/users/user", :object => current_user }
        end
      end
    else
      redirect_to new_session_path
    end
  end

  # PUT /user_pauses/1
  # PUT /user_pauses/1.xml
  def update
    @user_pause = UserPause.find(params[:id])

    if current_user.is_admin || @user_pause.user == current_user

      respond_to do |format|
        if @user_pause.update_attributes(params[:user_pause])
          flash[:notice] = 'UserPause was successfully updated.'
          format.html { redirect_to(@user_pause) }
          format.xml  { head :ok }
          format.js   { render :partial => "/users/user", :object => current_user }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @user_pause.errors, :status => :unprocessable_entity }
          format.js   { render :partial => "/users/user", :object => current_user }
        end
      end
    else
      redirect_to new_session_path
    end
  end

  # DELETE /user_pauses/1
  # DELETE /user_pauses/1.xml
  def destroy
    @user_pause = UserPause.find(params[:id])
    
    if current_user.is_admin
      @user_pause.destroy

      respond_to do |format|
        format.html { redirect_to(user_pauses_url) }
        format.xml  { head :ok }
      end
    else
      redirect_to new_session_path
    end
  end
end
