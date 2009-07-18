class UserAlertsController < ApplicationController
  before_filter :login_required

  # GET /user_alerts
  # GET /user_alerts.xml
  def index
    if current_user.is_admin
      @user_alerts = UserAlert.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @user_alerts }
      end
    else
      redirect_to new_session_path
    end
  end

  # GET /user_alerts/1
  # GET /user_alerts/1.xml
  def show
    if current_user.is_admin
      @user_alert = UserAlert.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @user_alert }
      end
    else
      redirect_to new_session_path
    end
  end

  # GET /user_alerts/new
  # GET /user_alerts/new.xml
  def new
    if current_user.is_admin
      @user_alert = UserAlert.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @user_alert }
      end
    else
      redirect_to new_session_path
    end
  end

  # GET /user_alerts/1/edit
  def edit
    if current_user.is_admin
      @user_alert = UserAlert.find(params[:id])
    else
      redirect_to new_session_path
    end
  end

  # POST /user_alerts
  # POST /user_alerts.xml
  def create
    if current_user.is_admin
      @user_alert = UserAlert.new(params[:user_alert])

      respond_to do |format|
        if @user_alert.save
          flash[:notice] = 'UserAlert was successfully created.'
          format.html { redirect_to(@user_alert) }
          format.xml  { render :xml => @user_alert, :status => :created, :location => @user_alert }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @user_alert.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to new_session_path
    end
  end

  # PUT /user_alerts/1
  # PUT /user_alerts/1.xml
  def update
    @user_alert = UserAlert.find(params[:id])
    if current_user.is_admin || current_user == @user_alert.user
      respond_to do |format|
        if @user_alert.update_attributes(params[:user_alert])
          flash[:notice] = 'UserAlert was successfully updated.'
          format.html { redirect_to(@user_alert) }
          format.xml  { head :ok }
          format.js   { render :partial => '/users/user', :object => current_user }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @user_alert.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to new_session_path
    end
  end

  # DELETE /user_alerts/1
  # DELETE /user_alerts/1.xml
  def destroy
    if current_user.is_admin
      @user_alert = UserAlert.find(params[:id])
      @user_alert.destroy

      respond_to do |format|
        format.html { redirect_to(user_alerts_url) }
        format.xml  { head :ok }
      end
    else
      redirect_to new_session_path
    end
  end
end
