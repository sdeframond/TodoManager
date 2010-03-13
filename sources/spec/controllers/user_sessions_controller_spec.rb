require File.dirname(__FILE__) + '/../spec_helper'

describe UserSessionsController do
    fixtures :users
    before(:each) do
      activate_authlogic
      @valid_attributes = {
        :email => "toto@toto.com",
        :password => "toto"
      }
      @invalid_attributes = {
        :email => "nonexistant@toto.com",
        :password => "blabla"
      }
    end
  
  describe "when not logged in" do
  
    it "new action should render login form" do
      get :new
      assigns[:user_session].should be_new_record
      response.should render_template(:new)
    end
    
    it "destroy action should redirect to root" do
      get :destroy
      response.should redirect_to root_url
    end

    describe UserSessionsController, "create (login) action" do
      
      it "should redirect to root with notice on successful login" do
        post :create, :user_session => @valid_attributes
        flash[:notice].should_not be_nil
        assigns[:user_session].should_not be_new_record
        response.should redirect_to(root_url)
      end
      
      it "should re-render login form on failed login" do
        post :create, :user_session => @invalid_attributes
        flash[:notice].should be_nil
        assigns[:user_session].should be_new_record
        response.should render_template(:new)
      end
      
      it "should pass parameters to the session" do
        post :create, :user_session => @valid_attributes
        assigns[:user_session].email.should == "toto@toto.com"
      end
    end
  end
  
  describe "when logged in" do
    before(:each) do
        UserSession.create(User.first)
    end
    
    it "new action should redirect to root" do
      get :new
      response.should redirect_to root_url
    end
    
    it "create action should redirect to root" do
      post :create
      response.should redirect_to root_url
    end

    describe UserSessionsController, "destroy (logout) action" do
      
      it "should redirect to root with notice" do
        get :destroy
        flash[:notice].should_not be_nil
        response.should redirect_to root_url
      end
      
      it "should destroy session" do
        get :destroy
        UserSession.find.should be_nil
      end
    end
  end
end
