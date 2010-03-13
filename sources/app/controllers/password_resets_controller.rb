class PasswordResetsController < ApplicationController
  
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
   
  def new  
    render  
  end  
    
  def create  
    @user = User.find_by_email(params[:email])  
    if @user
      @user.deliver_password_reset_instructions!  
      flash[:notice] = "Instructions to reset your password have been " +
        "emailed to you. Please check your email."  
      redirect_to root_url  
    else  
      flash[:notice] = "No user was found with that email address"  
      render :action => :new  
    end  
  end  
  
  def edit
    render
  end
  
  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = "Password updated !"
      redirect_to user_url(@user)
    else
      render :action => :edit
    end
  end
  
  private
  
  def load_user_using_perishable_token
    if current_user == nil
      @user = User.find_using_perishable_token(params[:id])
      unless @user
        flash[:notice] = "Oooops ! This token doesn't work"
        redirect_to root_url
      end
    else
      @user = current_user
    end
  end
  
end
