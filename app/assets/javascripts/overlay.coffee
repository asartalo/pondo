unloader = null
app.showOverlay = (callback) ->
  pu.selectAndEach 'body', (body) ->
    body.classList.add('disable-interaction')

  pu.selectAndEach '.disable-overlay', (overlay) ->
    unloader = pu.listenOnce overlay, 'click', (e) ->
      callback.call overlay, e

app.hideOverlay = (callback) ->
  pu.selectAndEach '.disable-overlay', (overlay) ->
    pu.animateCss overlay, 'fade-out', ->
      pu.selectAndEach 'body', (body) ->
        body.classList.remove('disable-interaction')

  unloader()
