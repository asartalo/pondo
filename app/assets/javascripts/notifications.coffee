app.load '.notifications', (el) ->
  app.delay 5, ->
    el.animateCss 'fade-out-up', ->
      el.hide()

