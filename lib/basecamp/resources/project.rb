module Basecamp
  class Project < Basecamp::Resource
    def time_entries(options = {})
      @time_entries ||= TimeEntry.find(:all, :params => options.merge(:project_id => id))
    end

    def messages
      @messages ||= Message.archive(id).map do |msg|
        Message.find(msg.id)
      end
    end

    def milestones
      @milestones ||= Milestone.list(id)
    end

    def todos
      @todos ||= TodoList.all(id)
    end
    
  end
end