class OfficeHoursController < ApplicationController
  layout "admin"

  before_filter :login_required

  def index
    @office_hours = OfficeHour.all
  end
  
  def show
    @office_hour = OfficeHour.find(params[:id])
  end
  
  def new
    @office_hour = OfficeHour.new
  end
  
  def create
    @office_hour = OfficeHour.new(params[:office_hour])
    if @office_hour.save
      flash[:notice] = "Successfully created office hour."
      redirect_to @office_hour
    else
      render :action => 'new'
    end
  end
  
  def edit
    @office_hour = OfficeHour.find(params[:id])
  end
  
  def update
    @office_hour = OfficeHour.find(params[:id])
    if @office_hour.update_attributes(params[:office_hour])
      flash[:notice] = "Successfully updated office hour."
      redirect_to @office_hour
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @office_hour = OfficeHour.find(params[:id])
    @office_hour.destroy
    flash[:notice] = "Successfully destroyed office hour."
    redirect_to office_hours_url
  end

  protected
    def authorized?
      logged_in? && current_user.is_admin
    end
end