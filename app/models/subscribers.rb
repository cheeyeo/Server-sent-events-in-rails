require "thread"

module Subscribers
  mattr_reader :subscribers
  @@subscribers = []

  # Subscribe to all published events.
  def self.subscribe(subscriber)
    subscribers << subscriber
  end

  # Unsubscribe an existing subscriber.
  def self.unsubscribe(subscriber)
    subscribers.delete(subscriber)
  end

  def self.add(name, data={})
    Thread.new do
      subscribers.each { |s| s << {event: name, data: JSON.generate(data)} }
    end
  end

  def self.start_timer(event, time)
    Thread.new do
      while true
        p "TIME LOOP"
        subscribers.each { |s| s << {event: event, data: JSON.generate({})} }
        sleep(time)
      end
    end
  end
end
