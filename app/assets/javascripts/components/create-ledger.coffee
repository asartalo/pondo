$document = $(document)

app.hashChange "create-ledger",
  ->
    pu.selectAndEach '#create-ledger', (el) ->
      el.classList.add('active')
      pu.animateCss el, 'zoom-in'

    pu.selectAndEach '#create-ledger a[href="#"]', (el) ->
      cancel = el
      app.showOverlay ->
        cancel.click() if cancel


  ->
    pu.selectAndEach '#create-ledger', (el) ->
      pu.animateCss el, 'zoom-out', ->
        el.classList.remove('active')

    app.hideOverlay()
