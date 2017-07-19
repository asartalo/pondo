app.load '.notifications', (notifications) ->
  el = notifications[0]
  shown = true
  hide = ->
    if shown
      pu.animateCss el, 'fade-out-down', ->
        pu.hide(el)
        unloader()
        shown = false

  unloader = pu.listenOnce el, 'click', hide
  app.delay 5, hide

