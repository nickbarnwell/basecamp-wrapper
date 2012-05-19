module Basecamp
 class Attachment < Basecamp::Resource
    parent_resources :project, :message, :milestone, :comment, :todo_item, :comment

    def to_xml(options = {})
      { :file => attributes, :category_id => category_id }.to_xml(options)
    end

    def download_file(path=nil)
      unless path 
        path = "/tmp/#{name}"
      end
      
      response = Basecamp.connection.get(download_url)
      File.open(path, 'wb') do |f|
        f << response.body
        f.close
      end
    end

    def save
      response = Basecamp.connection.post('/upload', content, 'Content-Type' => 'application/octet-stream')

      if response.code == '200'
        self.id = Hash.from_xml(response.body)['upload']['id']
        true
      else
        raise "Could not save attachment: #{response.message} (#{response.code})"
      end
    end
  end
end