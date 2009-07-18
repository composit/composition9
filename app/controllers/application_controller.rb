# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '08564689b8a8fd7c5cb658591d39cecb'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password
  include AuthenticatedSystem

  before_filter :no_cache, :only => [:new]

  private
    def no_cache
      response.headers["Last-Modified"] = Time.zone.now.httpdate
      response.headers["Expires"] = 0.to_s
      # HTTP 1.0
      response.headers["Pragma"] = "no-cache"
      # HTTP 1.1 ‘pre-check=0, post-check=0′ (IE specific)
      response.headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age=0, pre-check=0, post-check=0"
    end
end
