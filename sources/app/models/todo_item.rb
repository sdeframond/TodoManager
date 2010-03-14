class TodoItem < ActiveRecord::Base
  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  belongs_to :parent, :class_name => "TodoItem", :foreign_key => "todo_item_id"
  has_many :children, :class_name => "TodoItem", :dependent => :destroy
end
