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
    
    it "destroy action should return false" do
      delete :destroy, :id => 1
      response.should have_text(false.to_json)
    end

    describe "create (login) action" do
      
      it "should return true on successful login" do
        post :create, :user_session => @valid_attributes
        #flash[:notice].should_not be_nil
        assigns[:user_session].should_not be_new_record
        response.should have_text(true.to_json)
      end
      
      it "should return false on failed login" do
        post :create, :user_session => @invalid_attributes
        #flash[:notice].should be_nil
        assigns[:user_session].should be_new_record
        response.should have_text(false.to_json)
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
    
    it "create action should return false" do
      post :create
      response.should have_text(false.to_json)
    end
    
    describe "destroy (logout) action" do
      
      it "should return true" do
        delete :destroy, :id => UserSession.find
        #flash[:notice].should_not be_nil
        response.should have_text(true.to_json)
      end
      
      it "should destroy session" do
        delete :destroy, :id => UserSession.find
        UserSession.find.should be_nil
      end
    end
  end
end
