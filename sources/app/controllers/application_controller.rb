# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  helper_method :current_user
  
  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def require_user(redirect=nil)
    unless current_user
      redirect_to(redirect.nil? ? new_user_session_url : redirect)
      return false
    end
    true
  end
  
  def require_no_user(redirect=nil)
    if current_user
      redirect_to(redirect.nil? ? user_url(current_user) : redirect)
      return false
    end
    true
  end
  
end
