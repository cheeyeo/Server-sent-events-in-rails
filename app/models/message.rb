class Message < ActiveRecord::Base
  def to_chat
    {name: self.name, content: self.content}
  end
end
