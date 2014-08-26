class MessagesController < ApplicationController
  include ActionController::Live

  def index
    @messages = Message.all
  end

  def create
    response.headers["Content-Type"] = "text/javascript"
    attributes = params.require(:message).permit(:content, :name)
    @message = Message.create(attributes)
    Subscribers.add('message.create', @message.to_chat)
  end

  def events
    sse = SSESubscriber.new
    response.headers["Cache-Control"] = "no-cache"
    response.headers["Content-Type"] = "text/event-stream"
    sse.each {|event| response.stream.write event }
  rescue IOError
    logger.error "Stream closed (IOError)"
    sse.close
    response.stream.close
  rescue Errno::ECONNRESET => e
    logger.error "Stream closed (Errno)"
  else
    logger.error "Stream closed (Normaly)"
  ensure
    sse.close
    response.stream.close
  end
end
