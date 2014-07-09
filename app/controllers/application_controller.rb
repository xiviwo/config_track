# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
include AuthenticatedSystem
before_filter :init_session_var
before_filter :login_required, :except => [:new,:create]

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
    def init_session_var
      session[:search] = params[:search] if !params[:search].nil? || params[:commit] == as_('Search')
    end
	
		
	ActiveScaffold.set_defaults do |c|
		c.theme = :default
		c.ignore_columns.add [:created_at, :updated_at, :lock_version]
		c.list.per_page = 10
		
	end
end
