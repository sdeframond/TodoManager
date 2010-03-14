class UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:edit, :update, :account]

  def new
    @user = User.new
  end
  
  def account
      render :json => current_user
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully created user."
      #redirect_to root_url
      render :json => true
    else
      render :json => false
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      render :json => true
    else
      render :json => false
    end
  end
end
