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
  
  def require_user(redirection=nil)
    unless current_user
      if redirection
        redirect_to redirection
      else
        render :nothing => true, :status => :forbidden
      end
      return false
    end
    true
  end
  
  def require_no_user(redirection=nil)
    if current_user
      if redirection
        redirect_to redirection
      else
        render :json => false
      end
      return false
    end
    true
  end
  
end
