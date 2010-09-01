# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  layout "admin"

  # render new.rhtml
  def new
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      flash[:notice] = "Logged in successfully"
      if current_user.clients.length == 0
        flash[:notice] = "The administrator still needs to assign you to a client"
        redirect_to new_session_path
      elsif current_user.is_admin
        redirect_to clients_path
      else
        client_id = current_user.clients.first.id.to_s
        # redirect_to projects_path( :client_id => client_id )
        redirect_to client_path( client_id )
      end
    else
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
end
