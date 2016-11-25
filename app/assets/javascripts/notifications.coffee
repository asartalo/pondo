app.load '.notifications', (el) ->
  app.delay 5, ->
    el.animateCss 'fadeOut', ->
      el.hide()

