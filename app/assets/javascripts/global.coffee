$document = $(document)

$document.on 'ajax:complete', (e, response) ->
  result = response.responseJSON
  if result && result.for && result.for.length > 0
    status = "error"
    if response.status < 300 && result.success
      status = "success"
    event = $.Event("ax:#{result.for}:#{status}")
    event.target = e.target
    $(document).trigger event, result

dispatchUnloadEvent = ->
  event = document.createEvent('Events')
  event.initEvent 'turbolinks:unload', true, false
  document.dispatchEvent event
  return

addEventListener 'beforeunload', dispatchUnloadEvent
addEventListener 'turbolinks:before-render', dispatchUnloadEvent
