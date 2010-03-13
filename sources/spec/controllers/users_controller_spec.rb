require File.dirname(__FILE__) + '/../spec_helper'
 
describe UsersController do
  fixtures :users
  before(:each) do
    activate_authlogic
  end
  
  describe "when not logged in" do
    
    it "edit action should redirect to the login page" do
      get :edit
      response.should redirect_to(new_user_session_url)
    end

    it "update action should redirect to the login page" do
      post :update
      response.should redirect_to(new_user_session_url)
    end
  
    it "new action should render new form" do
      get :new
      response.should render_template(:new)
    end

    describe UsersController, "create action" do
      
      it "should redirect to root with a notice on successful save" do
        User.any_instance.stubs(:valid?).returns(true)
        post :create
        flash[:notice].should_not be_nil
        assigns[:user].should_not be_new_record
        response.should redirect_to(root_url)
      end
      
      it "should re-render new template on failed save" do
        User.any_instance.stubs(:valid?).returns(false)
        post :create
        assigns[:user].should be_new_record
        response.should render_template(:new)
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
    
    it "new action should redirect to user account" do
      get :new
      response.should redirect_to user_url(User.first)
    end

    it "create action should redirect to user account" do
      post :create
      response.should redirect_to user_url(User.first)
    end
    
    it "edit action should render edit form" do
      get :edit, :id => User.first
      response.should render_template(:edit)
    end

    describe UsersController, "update action" do
      
      it "should pass parameters to the user" do
        post :update, :id => User.first, :user => {:email => 'test@test.test'}
        assigns[:user].email.should == 'test@test.test'
      end

      it "should redirect to root with notice on successful update" do
        User.any_instance.stubs(:valid?).returns(true)
        post :update, :id => User.first
        flash[:notice].should_not be_nil
        response.should redirect_to(root_url)
      end
      
      it "should re-render edit template on failed update" do
        User.any_instance.stubs(:valid?).returns(false)
        post :update, :id => User.first
        response.should render_template(:edit)
      end
    end
  end
end
