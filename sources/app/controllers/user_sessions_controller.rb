class UserSessionsController < ApplicationController
  def new
    if current_user == nil
      @user_session = UserSession.new
    else
      redirect_to root_url
    end
  end
  
  def create
    if current_user == nil
      @user_session = UserSession.new(params[:user_session])
      if @user_session.save
        flash[:notice] = "Successfully created user session."
        redirect_to root_url
      else
        render :action => 'new'
      end
    else
      redirect_to root_url
    end
  end
  
  def destroy
    @user_session = UserSession.find
    if @user_session != nil
      @user_session.destroy
      flash[:notice] = "Successfully destroyed user session."
      redirect_to root_url
    else
      redirect_to root_url
    end
  end
end
