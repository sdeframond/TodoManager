require 'spec_helper'

describe "/todo_items/show" do
  before(:each) do
    render 'todo_items/show'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/todo_items/show])
  end
end
