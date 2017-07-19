unloader = null

opening = false
app.showOverlay = (callback) ->
  opening = true
  pu.selectAndEach 'body', (body) ->
    body.classList.add('disable-interaction')

  pu.selectAndEach '.disable-overlay', (overlay) ->
    unloader = pu.listenOnce overlay, 'click', (e) ->
      if callback
        callback.call overlay, e
  app.delay 0.03, ->
    opening = false

app.hideOverlay = (callback) ->
  app.delay 0.03, ->
    unless opening
      pu.selectAndEach '.disable-overlay', (overlay) ->
        pu.animateCss overlay, 'fade-out', ->
          pu.selectAndEach 'body', (body) ->
            body.classList.remove('disable-interaction')

    unloader()

  if callback
    callback()
