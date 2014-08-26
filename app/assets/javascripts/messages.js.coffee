console.log 'Messages JS'

source = new EventSource('/messages/events')

source.addEventListener "message.create", (e) ->
  message  = JSON.parse(e.data)
  $('#chat').append($('<li>').text("#{message.name}: #{message.content}"))

source.addEventListener "ping", (e) ->
  console.log 'heartbeat'

