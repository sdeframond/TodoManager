class UserSessionsController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully created user session."
      render :json => true
    else
      render :json => false
    end
  end
  
  def destroy
    @user_session = UserSession.find
    if @user_session
      @user_session.destroy
      flash[:notice] = "Successfully destroyed user session."
      render :json => true
    else
      render :json => false
    end
  end
end
