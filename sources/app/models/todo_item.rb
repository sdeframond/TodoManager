class TodoItem < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"
  belongs_to :parent, :class_name => "TodoItem"
  has_many :children, :class_name => "TodoItem", :dependent => :destroy
end
