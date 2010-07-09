# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticationHandling
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  def emailsender(from,to,msg,sub) 
    cc='' 
    Notifier.deliver_message(to,msg,sub,from,cc,nil)   
  end
end
