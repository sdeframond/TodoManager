class UsersController < ApplicationController
  def new
    if current_user == nil
      @user = User.new
    else
      redirect_to user_url(current_user)
    end
  end
  
  def create
    if current_user == nil
      @user = User.new(params[:user])
      if @user.save
        flash[:notice] = "Successfully created user."
        redirect_to root_url
      else
        render :action => 'new'
      end
    else
      redirect_to user_url(current_user)
    end
  end
  
  def edit
    if current_user != nil
      @user = current_user
    else
      redirect_to new_user_session_url
    end
  end
  
  def update
    if current_user != nil
      @user = current_user
      if @user.update_attributes(params[:user])
        flash[:notice] = "Successfully updated user."
        redirect_to root_url
      else
        render :action => 'edit'
      end
    else
      redirect_to new_user_session_url
    end
  end
end
