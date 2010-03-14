require 'spec_helper'

describe TodoItem do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :todo_item_id => 1,
      :name => "value for name",
      :description => "value for description",
      :due_date => Time.now,
      :priority => 1,
      :complete => false
    }
  end

  it "should create a new instance given valid attributes" do
    TodoItem.create!(@valid_attributes)
  end
end
