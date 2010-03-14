require File.dirname(__FILE__) + '/../spec_helper'
 
describe UsersController do
  fixtures :users
  before(:each) do
    activate_authlogic
  end
  
  describe "when not logged in" do

    it "account action should return 403 Forbidden status" do
      get :account
      response.code.should == "403"
    end

    it "update action should return 403 Forbidden status" do
      post :update
      response.code.should == "403"
    end

    describe "create action" do
      
      it "should return true on successful save" do
        User.any_instance.stubs(:valid?).returns(true)
        post :create
        #flash[:notice].should_not be_nil
        assigns[:user].should_not be_new_record
        response.should have_text(true.to_json)
      end
      
      it "should return false on failed save" do
        User.any_instance.stubs(:valid?).returns(false)
        post :create
        assigns[:user].should be_new_record
        response.should have_text(false.to_json)
      end
      
      it "should pass parameters to the user" do
        post :create, :user => {:email => 'test@test.test'}
        assigns[:user].email.should == 'test@test.test'
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
    
    it "account action should return the current user" do
      post :account
      response.should have_text(User.first.to_json)
    end

    describe "update action" do
      
      it "should pass parameters to the user" do
        post :update, :id => User.first, :user => {:email => 'test@test.test'}
        assigns[:user].email.should == 'test@test.test'
      end

      it "should return true on successful update" do
        User.any_instance.stubs(:valid?).returns(true)
        post :update, :id => User.first
        #flash[:notice].should_not be_nil
        response.should have_text(true.to_json)
      end
      
      it "should retrun false on failed update" do
        User.any_instance.stubs(:valid?).returns(false)
        post :update, :id => User.first
        response.should have_text(false.to_json)
      end
    end
  end
end
