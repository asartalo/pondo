@app ||= {}

$document = $(document)

# Load and unload depending if elements exist on the page
app.load = (selector, loader, unloader) ->
  $document.on 'nitrolinks:load', ->
    elements = $(selector)
    if elements.length > 0 && loader
      loader(elements)

  if unloader
    $document.on 'nitrolinks:visit', ->
      elements = $(selector)
      if elements.length > 0
        unloader(elements)

app.afterLoad = (selector, loader) ->
  myLoader = (e) ->
    if selector
      elements = $(selector)
      if elements.length > 0 && loader
        loader(elements)
    else
      loader(e.target)
    $document.off 'nitrolinks:load', myLoader

  $document.on 'nitrolinks:load',  myLoader

app.reload = ->
  nitrolinks.visit(window.location.toString())

app.delay = (seconds, callback) ->
  window.setTimeout callback, seconds * 1000

dialogElement = null
dialogId = null

getDialog = ->
  dialog = $('dialog')[0]
  # if !dialog.showModal
  #   dialogPolyfill.registerDialog(dialog)
  dialog

showDialog = (options = {}) ->
  dialog = getDialog()
  dialog.showModal()
  event = $.Event('dialog-load')
  event.target = dialog
  $document.trigger event

closeDialog = ->
  dialog = getDialog()
  return unless dialog
  form = $(dialog).find('form')
  if form.length > 0
    form[0].reset()
  if dialog.open
    dialog.close()
  if dialogId
    $(dialogId).append(dialogElement)
  else
    dialogElement.detach() if dialogElement
  dialogElement = null
  dialogId = null

app.showDialog = showDialog
app.closeDialog = closeDialog

$document.on 'click', 'dialog .close', (e) ->
  closeDialog()

$document.on 'nitrolinks:visit', ->
  closeDialog()

$document.on 'click', '.dialog-open', (e) ->
  e.preventDefault()
  target = $(e.target)
  if target.is('.dialog-open')
    button = target
  else
    button = target.closest('.dialog-open')
  dialogId = button.attr('href')
  container = $("#{dialogId}")
  width = container.data('width') || ""
  dialogElement = $("#{dialogId} > *").detach()

  $('dialog').css(width: width).find('.dialog-content').append(dialogElement)
  showDialog()

$document.on 'click', '.dialog-open-remote', (e) ->
  e.preventDefault()
  target = $(e.target)
  if target.is('.dialog-open-remote')
    button = target
  else
    button = target.closest('.dialog-open-remote')
  location = button.attr('href')
  width = button.data('width') || ""
  $.ajax(
    location,
    success: (data, status) ->
      dialogElement = $(data)
      $('dialog').css(width: width).find('.dialog-content').append(dialogElement)
      showDialog()
  )

$

