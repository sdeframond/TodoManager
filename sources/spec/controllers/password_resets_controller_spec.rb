require 'spec_helper'

describe PasswordResetsController do
  fixtures :users
  before(:each) do
    activate_authlogic
    @valid_attributes = {
      :password => "newpass",
      :password_confirmation => "newpass"
    }
    @invalid_attributes = {
      :password => "newpass",
      :password_confirmation => "differentpass"
    }
  end
  
  describe "when logged in" do
    before(:each) do
        UserSession.create(User.first)
    end
    
    it "edit action should render edit template" do
      get :edit
      response.should render_template :edit
    end
    
    describe "update action" do
      it "should pass parameters to user" do
        post :update, :user => @valid_attributes
        assigns[:user].password.should == "newpass"
      end
      
      it "should redirect to user page with notice when passwords match" do
        post :update, :user => @valid_attributes
        flash[:notice].should_not be_nil
        response.should redirect_to user_url(User.first)
      end
      
      it "should re-render edit template when passwords do not match" do
        post :update, :user => @invalid_attributes
        response.should render_template :edit
      end
    end
    
    it "create action should redirect to root" do
      post :create
      response.should_not redirect_to root_url
    end
  end
  
  describe "when using a perishable token" do
    it "edit action should render edit template" do
      get :edit, :id => users(:toto).perishable_token
      response.should render_template :edit
    end
    
    describe "update action" do
      it "should pass parameters to user" do
        post :update, :user => @valid_attributes, :id => users(:toto).perishable_token
        assigns[:user].password.should == "newpass"
      end
      
      it "should redirect to user page with notice when passwords match" do
        post :update, :user => @valid_attributes, :id => users(:toto).perishable_token
        flash[:notice].should_not be_nil
        response.should redirect_to user_url(users(:toto))
      end
      
      it "should re-render edit template when passwords do not match" do
        post :update, :user => @invalid_attributes, :id => users(:toto).perishable_token
        response.should render_template :edit
      end
    end
  end
  
  describe "when not logged in" do
    it "new action should render new template" do
      get :new
      response.should render_template :new
    end
    
    describe "create action" do
      it "should send an email and redirect to root_url with notice when user exists" do
        post :create, :email => 'toto@toto.com'
        response.should send_email
        response.should redirect_to root_url
      end
      
      it "should re-render new template with notice when user does not exists" do
        post :create, :email => 'nonexistant@none.host'
        response.should render_template :new
      end
    end
    
    it "edit action should redirect to root" do
      get :edit
      response.should redirect_to root_url
    end
    
    it "update action should redirect to root" do
      post :update
      response.should redirect_to root_url
    end
  end
  
end
