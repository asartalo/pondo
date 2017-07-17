app.load '.notifications', (notifications) ->
  el = notifications[0]
  app.delay 5, ->
    pu.animateCss el, 'fade-out-down', ->
      pu.hide(el)

