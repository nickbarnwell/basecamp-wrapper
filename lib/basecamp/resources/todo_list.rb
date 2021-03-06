module Basecamp; class TodoList < Basecamp::Resource
  parent_resources :project

  # Returns all lists for a project. If complete is true, only completed lists
  # are returned. If complete is false, only uncompleted lists are returned.
  def self.all(project_id, complete = nil)
    filter = case complete
      when nil   then "all"
      when true  then "finished"
      when false then "pending"
      else raise ArgumentError, "invalid value for `complete'"
    end

    find(:all, :params => { :project_id => project_id, :filter => filter })
  end

  def todo_items(options = {})
    @todo_items ||= TodoItem.find(:all, :params => options.merge(:todo_list_id => id))
  end

  def items(options = {})
    todo_items(options)
  end
  
end; end