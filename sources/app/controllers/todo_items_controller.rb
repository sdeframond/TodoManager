class TodoItemsController < ApplicationController

  before_filter :require_user
  before_filter :load_todo_item_and_check_owner, :only => [:show, :update]

  def index
    # TODO: find a better way to do the id verification
    if User.exists?(params[:user_id])
      if User.find(params[:user_id]) == current_user
        render :json => current_user.todo_items
      else
        render :status => :not_found
      end
    else
      render :status => :not_found
    end
  end

  def show
    render :json => @todo_item
  end
  
  def create
    @todo_item = TodoItem.new(params[:todo_item])
    if @todo_item.save
      render :json => true
    else
      render :json => false
    end
  end

  def update
    if @todo_item.update_attributes(params[:todo_item])
      render :json => true
    else
      render :json => false
    end
  end
  
  private
  
  def load_todo_item_and_check_owner
    if TodoItem.exists?(params[:id])
      @todo_item = TodoItem.find(params[:id])
      if @todo_item.owner != current_user
        render :status => :not_found
      end
    else
      render :status => :not_found
    end
  end

end
