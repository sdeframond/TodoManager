require File.expand_path(File.dirname(__FILE__)  + '/../spec_helper')

describe UserSession do
  fixtures :users
  before(:each) do
    activate_authlogic
    @valid_attributes = {
      :password => "toto",
      :email => "toto@toto.com",
    }
  end

  it "should create a new instance given valid attributes" do
    UserSession.create!(@valid_attributes)
  end
end
