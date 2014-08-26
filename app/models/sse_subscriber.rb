require "thread"
require_relative "subscribers"

class SSESubscriber
  def initialize(queue = Queue.new)
    @queue = queue
    Subscribers.subscribe(@queue)
  end

  def each
    consumer = Thread.new do
      p "SUBSCRIBER LOOP"
      event = @queue.pop
      yield "event: #{event[:event]}\ndata: #{event[:data]}\n\n"
    end

    consumer.join
  end

  def close
    Subscribers.unsubscribe(@queue)
  end
end
