require 'spec_helper'

describe TodoItemsController do
  fixtures :todo_items
  fixtures :users
  
  before :each do
    activate_authlogic
    @valid_attributes = {
      :owner => users(:toto),
      :name => "Another Task",
      :complete => false
    }
  end

  describe "when logged in" do
    before(:each) do
      UserSession.create(users(:toto))
    end
    
    describe "index action" do
      it "should return 404 when user's id is not current user's one" do
        get :index, :user_id => users(:tata).id
        response.code.should == "404"
      end
      it "should return 404 when user does not exist" do
        get :index, :user_id => -1
        response.code.should == "404"
      end
      it "should return the list of the todo items for the current user" do
        get :index, :user_id => users(:toto)
        response.should have_text(users(:toto).todo_items.to_json)
      end
    end
    
    describe "show action" do
      it "should return item's data when it belongs to the current user" do
        get :show, :id => todo_items(:one)
        response.should have_text(todo_items(:one).to_json)
      end
      it "should return 404 when item does not belong to the current user" do
        get :show, :id => todo_items(:three)
        response.code.should == "404"
      end
      it "should return 404 when item does exist" do
        get :show, :id => -1
        response.code.should == "404"
      end
    end
    
    describe "create action" do
      it "should pass parameters to the todo item" do
        post :create, :todo_item => @valid_attributes
        assigns[:todo_item].name.should == @valid_attributes[:name]
      end
      it "should return true on successful save" do
        TodoItem.any_instance.stubs(:valid?).returns(true)
        post :create
        assigns[:todo_item].should_not be_new_record
        response.should have_text true.to_json
      end
      it "should return false on failed save" do
        TodoItem.any_instance.stubs(:valid?).returns(false)
        post :create
        assigns[:todo_item].should be_new_record
        response.should have_text false.to_json
      end
    end
    
    describe "update action" do
      it "should return 404 when item does not exist" do
        post :update, :id => -1
        response.code.should == "404"
      end
      it "should return 404 when item does not belong to the current user" do
        post :update, :id => todo_items(:three)
        response.code.should == "404"
      end
      it "should pass parameters to the todo item" do
        post :update, :id => todo_items(:one), :todo_item => @valid_attributes
        assigns[:todo_item].name.should == @valid_attributes[:name]
      end
      it "should return true on successful update" do
        TodoItem.any_instance.stubs(:valid?).returns(true)
        post :update, :id => todo_items(:one)
        response.should have_text true.to_json
      end
      it "should return false on failed update" do
        TodoItem.any_instance.stubs(:valid?).returns(false)
        post :update, :id => todo_items(:one)
        response.should have_text false.to_json
      end
    end
  end
  
  describe "when not logged in" do
    
    # We want to be able to be able to create todo before login in. This is
    # a feature of the interface, the backend only respond "403" when not
    # authenticated.
    
    after :each do
      response.code.should == "403"
    end
    
    it "index should return 403 status code" do
      get :index
    end
    it "show should return 403 status code" do
      get :show
    end
    it "create should return 403 status code" do
      post :create
    end
    it "update should return 403 status code" do
      post :update
    end
  end
end
